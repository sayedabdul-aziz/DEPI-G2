import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit()..getWishlist(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Wishlist')),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            var cubit = context.read<WishlistCubit>();
            if (state is! WishlistSuccessState) {
              return const Center(child: CircularProgressIndicator());
            } else if (cubit.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.bookmarkSvg,
                      height: 100,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Gap(20),
                    Text('Your wishlist is empty'),
                  ],
                ),
              );
            } else {
              return ListView.separated(
                padding: EdgeInsets.all(20),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: cubit.products.length,
                itemBuilder: (context, index) {
                  return WishlistCard(product: cubit.products[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class WishlistCard extends StatelessWidget {
  const WishlistCard({super.key, required this.product});

  final Product product;

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
        // remove item from wishlist
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
