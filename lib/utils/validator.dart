import 'package:igt_e_pass_app/resource/app_url.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validator {
  static String? validatePhoneNumber(String? validateText) {
    String text = validateText.toString().trim();
    final RegExp regExp = RegExp(r'^(?:[+0]855)?[0-9]{8,10}$');
    if (text.isEmpty) {
      //return ("Phone number is required");
      return AppLocalizations.of(Nav.ctx)!.phone_is_require;
    } else if (text[0] == '0') {
      if (text.length == 1) {
        //return ("Phone number is required");
        return AppLocalizations.of(Nav.ctx)!.phone_is_require_1;
      } else if (text.isEmpty) {
        //return ("Phone number is required 1");
        return AppLocalizations.of(Nav.ctx)!.phone_is_require_1;
      } else if (text[1] == '0') {
        //return ("Invalid phone number");
        return AppLocalizations.of(Nav.ctx)!.invalid_phone;
      } else if (text.length < 9 || text.length > 10) {
        return AppLocalizations.of(Nav.ctx)!.invalid_phone;
      } else if ((text[1] == '9' && text[2] == '7') &&
          (text.length > 10 || text.length < 10)) {
        //return ("This phone number has 10 digits");
        return AppLocalizations.of(Nav.ctx)!.phone_10_digits;
      } else if ((text[1] == '9' && text[2] == '6') &&
          (text.length > 10 || text.length < 10)) {
        return AppLocalizations.of(Nav.ctx)!.phone_10_digits;
      } else if ((text[1] == '8' && text[2] == '8') &&
          (text.length > 10 || text.length < 10)) {
        return AppLocalizations.of(Nav.ctx)!.phone_10_digits;
      } else if ((text[1] == '7' && text[2] == '1') &&
          (text.length > 10 || text.length < 10)) {
        return AppLocalizations.of(Nav.ctx)!.phone_10_digits;
      } else if ((text[1] == '1' && text[2] == '8') &&
          (text.length > 10 || text.length < 10)) {
        return AppLocalizations.of(Nav.ctx)!.phone_10_digits;
      } else if (text.length > 10) {
        //return ("Invalid phone number");
        return AppLocalizations.of(Nav.ctx)!.invalid_phone;
      } else if (!regExp.hasMatch(text)) {
        //return ("Invalid phone number 1");
        return AppLocalizations.of(Nav.ctx)!.invalid_phone_1;
      } else {
        return null;
      }
    } else {
      //return "Please add 0 in the beginning";
      return AppLocalizations.of(Nav.ctx)!.phone_begin_with_0;
    }
    //097,096,088,071 has 10 characters
    //return regex.hasMatch(text);
  }

  static String? validateEmail(String? validateText) {
    String text = validateText ?? '';
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (text.isEmpty) {
      //return ("Email is required");
      return AppLocalizations.of(Nav.ctx)!.email_is_required;
    } else if (!regExp.hasMatch(text)) {
      //return ("Your email is invalid");
      return AppLocalizations.of(Nav.ctx)!.invalid_email;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? param) {
    String password = param ?? '';
    if (password.isEmpty) {
      //return ("Password is required");
      return AppLocalizations.of(Nav.ctx)!.pw_is_required;
    } else if (password.toString().length < AppUrl.minPasswordLength) {
      //return ("Password must be at least 8 characters");
      return AppLocalizations.of(Nav.ctx)!.pw_must_be_8_char;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
      String comparedPassword, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      //return ("Confirm password is required");
      return AppLocalizations.of(Nav.ctx)!.cpw_is_required;
    } else if (comparedPassword != confirmPassword) {
      //return "Confirm password does not match";
      return AppLocalizations.of(Nav.ctx)!.cpw_dose_not_match;
    } else if (confirmPassword.toString().length < AppUrl.minPasswordLength) {
      //return ("Password must be at least 8 characters");
      return AppLocalizations.of(Nav.ctx)!.pw_must_be_8_char;
    } else {
      return null;
    }
  }
}

String? kNullInputValidator(String? v, String message) {
  String t = v ?? '';
  return t.trim().isNotEmpty ? null : message;
}
