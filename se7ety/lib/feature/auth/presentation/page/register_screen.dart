import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/helper/app_regex.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/core/widgets/custom_text_form_field.dart';
import 'package:se7ety/core/widgets/dialogs.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/core/widgets/password_text_form_field.dart';
import 'package:se7ety/feature/auth/data/models/user_type_enum.dart';
import 'package:se7ety/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/feature/auth/presentation/cubit/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisible = true;

  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(color: AppColors.primaryColor),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthSuccessState) {
            pop(context);
            log("Success");
          } else if (state is AuthErrorState) {
            pop(context);
            showMyDialog(context, state.error);
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', height: 200),
                    const SizedBox(height: 20),
                    Text(
                      'سجل دخول الان كـ "${handleUserType()}"',
                      style: TextStyles.title.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      controller: cubit.nameController,
                      keyboardType: TextInputType.text,

                      hintText: 'اسم المستخدم',
                      prefixIcon: Icon(Icons.person),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الاسم';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 25.0),
                    CustomTextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Sayed@example.com',
                      prefixIcon: Icon(Icons.email_rounded),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الايميل';
                        } else if (!AppRegex.isEmailValid(value)) {
                          return 'من فضلك ادخل الايميل صحيحا';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 25.0),
                    PasswordTextFormField(
                      controller: cubit.passwordController,
                      hintText: '********',
                      prefixIcon: const Icon(Icons.lock),
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                        return null;
                      },
                    ),

                    const Gap(30),
                    MainButton(
                      onPressed: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.register(userType: widget.userType);
                        }
                      },
                      text: "تسجيل حساب جديد",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لدي حساب ؟',
                            style: TextStyles.body.copyWith(
                              color: AppColors.darkColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              pushWithReplacement(
                                context,
                                Routes.login,
                                extra: widget.userType,
                              );
                            },
                            child: Text(
                              'سجل دخول',
                              style: TextStyles.body.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
