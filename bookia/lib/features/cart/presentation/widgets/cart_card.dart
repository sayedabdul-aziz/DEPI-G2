import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onUpdate,
  });

  final CartItem product;
  final Function() onDelete;
  final Function(int) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [const Icon(Icons.delete, color: Colors.white)],
        ),
      ),
      onDismissed: (direction) {
        onDelete();
      },
      child: Container(
        height: 145,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.itemProductImage ?? '',
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
            Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.itemProductName ?? '',
                    style: TextStyles.textStyle18,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(5),
                  Text(
                    '\$${product.itemProductPriceAfterDiscount}',
                    style: TextStyles.textStyle16,
                  ),
                  Gap(20),
                  _updateQuantityActions(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _updateQuantityActions(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if ((product.itemQuantity ?? 1) > 1) {
              int newQuantity = (product.itemQuantity ?? 1) - 1;
              onUpdate(newQuantity);
            } else {
              showMyDialog(context, 'Minimum quantity is 1', DialogType.error);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.remove),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            (product.itemQuantity ?? 1).toString(),
            style: TextStyles.textStyle16,
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          onTap: () {
            if ((product.itemQuantity ?? 1) < (product.itemProductStock ?? 1)) {
              int newQuantity = (product.itemQuantity ?? 1) + 1;
              onUpdate(newQuantity);
            } else {
              showMyDialog(context, 'Out of stock', DialogType.error);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.add),
          ),
        ),
        Spacer(),
        Text(
          'Total: \$${(product.itemTotal ?? 1).toStringAsFixed(1)}',
          style: TextStyles.textStyle16,
        ),
      ],
    );
  }
}
