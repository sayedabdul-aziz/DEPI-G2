import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/password_text_form_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthErrorState) {
          pop(context);
          showMyDialog(context, 'Auth Failed');
        } else if (state is AuthSuccessState) {
          pushToBase(context, Routes.main);
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
        ),
        body: _buildRegisterBody(),
        bottomNavigationBar: _bottomAction(),
      ),
    );
  }

  Padding _bottomAction() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account?", style: TextStyles.textStyle15),
          TextButton(
            onPressed: () {
              pushReplacementTo(context, Routes.login);
            },
            child: Text(
              "Sign in",
              style: TextStyles.textStyle15.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterBody() {
    var cubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.all(22),
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              Text(
                "Welcome back! Glad to see you, Again!",
                style: TextStyles.textStyle30,
              ),
              Gap(32),
              CustomTextFormField(
                controller: cubit.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                hintText: 'Full name',
              ),
              Gap(15),
              CustomTextFormField(
                controller: cubit.emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                hintText: 'Email',
              ),
              Gap(15),
              PasswordTextFormField(
                controller: cubit.passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                hintText: 'Password',
              ),
              Gap(15),
              PasswordTextFormField(
                controller: cubit.confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                hintText: 'Confirmation password',
              ),

              Gap(34),
              MainButton(
                text: 'Sign Up',
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    context.read<AuthCubit>().register();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
