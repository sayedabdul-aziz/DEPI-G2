import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var cubit = context.read<CartCubit>();
            var books = cubit.cartResponse?.data?.cartItems ?? [];
            if (state is! CartSuccessState) {
              return const Center(child: CircularProgressIndicator());
            } else if (books.isEmpty == true) {
              return _emptyCart();
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return CartCard(
                          product: books[index],
                          onDelete: () {
                            cubit.removeFromCart(
                              cartItemId: books[index].itemId ?? 0,
                            );
                          },
                          onUpdate: (q) {
                            cubit.updateQuantity(
                              cartItemId: books[index].itemId ?? 0,
                              quantity: q,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Gap(20),
                            Text('Total:', style: TextStyles.textStyle16),
                            const Spacer(),
                            Text(
                              '${cubit.cartResponse?.data?.total ?? 0} \$',
                              style: TextStyles.textStyle16,
                            ),
                            const Gap(20),
                          ],
                        ),
                        const Gap(10),
                        MainButton(text: 'Checkout', onPressed: () {}),
                        const Gap(20),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Center _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.cartSvg,
            height: 100,
            colorFilter: ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          const Gap(20),
          Text('Your cart is empty'),
        ],
      ),
    );
  }
}
