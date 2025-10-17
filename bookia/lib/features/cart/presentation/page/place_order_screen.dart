import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/helper/app_regex.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/cart/data/models/governorate/gov_list.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.total});
  final String total;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();
    return Scaffold(
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
      ),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CheckoutLoadingState) {
            showLoadingDialog(context);
          } else if (state is CheckoutSuccessState) {
            pushToBase(context, Routes.main, extra: 0);
          } else if (state is CheckoutErrorState) {
            pop(context);
            showMyDialog(context, 'Something went wrong');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Place Your Order', style: TextStyles.textStyle30),
                  const Gap(10),
                  Text(
                    'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                    style: TextStyles.textStyle16.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const Gap(25),
                  CustomTextFormField(
                    controller: cubit.nameController,
                    hintText: 'Full Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomTextFormField(
                    controller: cubit.emailController,
                    hintText: 'Email',
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!AppRegex.isEmailValid(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomTextFormField(
                    controller: cubit.addressController,
                    hintText: 'Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomTextFormField(
                    controller: cubit.phoneController,
                    hintText: 'Phone',
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone';
                      } else if (!AppRegex.isEgyptMobile(value)) {
                        return 'Please enter a valid phone';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomTextFormField(
                    controller: cubit.governorateController,
                    readOnly: true,
                    hintText: 'Governorate',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your governorate';
                      }
                      return null;
                    },
                    onTap: () {
                      selectGovernorate(context, cubit);
                    },
                  ),
                  const Gap(12),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Gap(20),
                  Text('Total:', style: TextStyles.textStyle20),
                  const Spacer(),
                  Text('$total \$', style: TextStyles.textStyle20),
                  const Gap(20),
                ],
              ),
              const Gap(10),
              MainButton(
                text: 'Submit Order',
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.placeOrder();
                  }
                },
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> selectGovernorate(BuildContext context, CartCubit cubit) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Governorate', style: TextStyles.textStyle24),
              Gap(10),
              Divider(),
              Gap(10),
              Expanded(
                child: ListView.separated(
                  itemCount: governorateList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        pop(context);
                        cubit.selectedGovId = governorateList[index].id ?? 0;
                        cubit.governorateController.text =
                            governorateList[index].governorateNameEn ?? '';
                      },
                      leading: Icon(Icons.location_on),
                      title: Text(
                        governorateList[index].governorateNameEn ?? '',
                        style: TextStyles.textStyle16,
                      ),

                      trailing: Icon(Icons.arrow_forward_ios),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
