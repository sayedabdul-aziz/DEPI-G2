import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:bookia/features/wishlist/presentation/widgets/wishlist_card.dart';
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
              return _emptyWishlist();
            } else {
              return ListView.separated(
                padding: EdgeInsets.all(20),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: cubit.products.length,
                itemBuilder: (context, index) {
                  return WishlistCard(
                    product: cubit.products[index],
                    onDelete: () {
                      cubit.removeFromWishlist(
                        id: cubit.products[index].id ?? 0,
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Center _emptyWishlist() {
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
  }
}
