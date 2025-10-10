import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

  final Product product;
  final Function() onDelete;

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
                product.image ?? '',
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
                    product.name ?? '',
                    style: TextStyles.textStyle18,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(5),
                  Text('\$${product.price}', style: TextStyles.textStyle16),
                  Gap(5),
                  Text(
                    product.description ?? '',
                    style: TextStyles.textStyle14.copyWith(
                      color: AppColors.greyColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
