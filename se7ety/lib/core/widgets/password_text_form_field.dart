import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? prefixIcon;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          child: Icon(Icons.remove_red_eye_rounded),
        ),
      ),
      validator: widget.validator,
    );
  }
}
