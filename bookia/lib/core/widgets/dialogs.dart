import 'package:flutter/material.dart';

showErrorDialog(BuildContext context, String message) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
}
