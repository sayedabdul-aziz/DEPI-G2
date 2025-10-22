import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 55,
    this.bgColor = AppColors.primaryColor,
    this.borderColor,
    this.textColor = AppColors.whiteColor,
  });

  final String text;
  final Function() onPressed;
  final double width;
  final double height;
  final Color bgColor;
  final Color textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: borderColor != null
                ? AppColors.darkColor
                : Colors.transparent,
          ),
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyles.body.copyWith(color: textColor)),
      ),
    );
  }
}
