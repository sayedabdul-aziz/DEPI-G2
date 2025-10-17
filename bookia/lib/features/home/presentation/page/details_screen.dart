import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          showLoadingDialog(context);
        } else if (state is HomeSuccessState) {
          pop(context);
          showMyDialog(context, state.message ?? '', DialogType.success);
        } else if (state is HomeErrorState) {
          pop(context);
          showMyDialog(context, 'Something went wrong');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(AppImages.backSvg),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<HomeCubit>().addToWishlist(id: product.id ?? 0);
              },
              icon: SvgPicture.asset(AppImages.bookmarkSvg),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Hero(
                    tag: product.id ?? '',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: product.image ?? '',
                        width: 185,
                        height: 270,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gap(20),
                  Text(product.name ?? '', style: TextStyles.textStyle20),
                  Gap(10),
                  Text(
                    product.category ?? '',
                    style: TextStyles.textStyle18.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Gap(20),
                  Text(
                    product.description ?? '',
                    style: TextStyles.textStyle14,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${product.price}', style: TextStyles.textStyle20),
                const Gap(40),
                Expanded(
                  child: MainButton(
                    bgColor: AppColors.darkColor,
                    text: 'Add To Cart',
                    onPressed: () {
                      context.read<HomeCubit>().addToCart(id: product.id ?? 0);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
