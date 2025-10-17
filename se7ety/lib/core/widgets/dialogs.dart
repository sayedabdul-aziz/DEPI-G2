import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/utils/app_colors.dart';

enum DialogType { success, error, info }

showMyDialog(
  BuildContext context,
  String message, [
  DialogType type = DialogType.error,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: type == DialogType.error
          ? Colors.red
          : type == DialogType.success
          ? AppColors.primaryColor
          : AppColors.secondaryColor,
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: AppColors.darkColor.withValues(alpha: 0.8),
    barrierDismissible: false,
    builder: (context) =>
        Center(child: Lottie.asset('assets/images/loading.json')),
  );
}
