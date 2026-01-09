import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/helper/extensions.dart';
import 'package:se7ety/core/presentation/cubit/theme_cubit.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/feature/auth/data/models/user_type_enum.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/welcome-bg.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          PositionedDirectional(
            top: 100,
            start: 25,
            end: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "welcome".tr(),
                      style: TextStyles.title.copyWith(
                        fontSize: 38,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Gap(15),
                    Text(
                      "sign_and_book".tr(),
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        var currentLocale = context.locale;
                        Locale newLocale = currentLocale.languageCode == 'ar'
                            ? Locale('en')
                            : Locale('ar');
                        context.setLocale(newLocale);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: context.theme.cardColor,
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.language),
                            const Gap(10),
                            Text('language'.tr(), style: TextStyles.body),
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        context.read<ThemeCubit>().changeTheme();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.dark_mode),
                            const Gap(10),
                            Text('theme'.tr(), style: TextStyles.body),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 80,
            start: 25,
            end: 25,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: SharedPref.isDarkTheme()
                    ? AppColors.darkColor.withValues(alpha: .5)
                    : AppColors.primaryColor.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: .3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'sign_as'.tr(),
                    style: TextStyles.title.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildUserButton(
                    title: 'doctor'.tr(),
                    onTap: () {
                      pushTo(context, Routes.login, extra: UserTypeEnum.doctor);
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildUserButton(
                    title: 'patient'.tr(),
                    onTap: () {
                      pushTo(
                        context,
                        Routes.login,
                        extra: UserTypeEnum.patient,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildUserButton({
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.accentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyles.title.copyWith(color: AppColors.darkColor),
          ),
        ),
      ),
    );
  }
}
