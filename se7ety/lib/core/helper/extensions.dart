import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension Localized on BuildContext {
  bool get isArabic => locale.languageCode == 'ar';
}

extension ThemeEx on BuildContext{
  ThemeData get theme => Theme.of(this);
}
