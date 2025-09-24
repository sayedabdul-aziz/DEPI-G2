import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/password_text_form_field.dart';
import 'package:bookia/features/auth/presentation/page/register_screen.dart';
import 'package:bookia/features/auth/presentation/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: _buildLoginBody(),
      bottomNavigationBar: _bottomAction(),
    );
  }

  Padding _bottomAction() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?", style: TextStyles.textStyle15),
          TextButton(
            onPressed: () {
              pushReplacementTo(context, RegisterScreen());
            },
            child: Text(
              "Sign Up",
              style: TextStyles.textStyle15.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildLoginBody() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                "Welcome back! Glad to see you, Again!",
                style: TextStyles.textStyle30,
              ),
              Gap(32),
              CustomTextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                hintText: 'Enter your email',
              ),
              Gap(15),
              PasswordTextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                hintText: 'Enter your password',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyles.textStyle15,
                  ),
                ),
              ),
              Gap(20),
              MainButton(
                text: 'Login',
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
              ),
              Gap(34),
              SocialLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
