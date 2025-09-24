import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/presentation/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcome,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Spacer(flex: 2),

                SvgPicture.asset(AppImages.logoSvg),
                const Gap(25),
                const Text(
                  'Order Your Book Now!',
                  style: TextStyles.textStyle18,
                ),

                Spacer(flex: 5),

                MainButton(
                  text: 'Login',
                  onPressed: () {
                    pushTo(context, LoginScreen());
                  },
                ),
                const Gap(15),
                MainButton(
                  text: 'Register',
                  bgColor: AppColors.backgroundColor,
                  borderColor: AppColors.darkColor,
                  textColor: AppColors.darkColor,
                  onPressed: () {
                    pushTo(context, RegisterScreen());
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
