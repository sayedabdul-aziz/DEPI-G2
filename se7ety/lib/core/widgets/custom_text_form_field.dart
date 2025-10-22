import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText,
    this.suffixIcon,
    this.readOnly = false,
    this.keyboardType,
    this.inputFormatters,
    this.onTap,
    this.prefixIcon,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      validator: validator,
      inputFormatters: inputFormatters,
      onTap: onTap,
    );
  }
}
