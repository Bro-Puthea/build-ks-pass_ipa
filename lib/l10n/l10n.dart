import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('km'),
    const Locale('zh'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'km':
        return 'Khmer';
      case 'zh':
        return 'Chinese';
      case 'en':
      default:
        return 'English';
    }
  }
}
