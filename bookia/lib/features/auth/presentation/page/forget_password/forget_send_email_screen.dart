import 'package:flutter/material.dart';

class ForgetSendEmailScreen extends StatelessWidget {
  const ForgetSendEmailScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'An email has been sent to $email with instructions to reset your password.',
        ),
      ),
    );
  }
}
