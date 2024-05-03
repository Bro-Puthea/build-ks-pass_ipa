import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText {
  static TextStyle? display4(BuildContext context) {
    return GoogleFonts.openSans(
            textStyle: Theme.of(context).textTheme.headline1)
        .copyWith(
      color: Colors.white,
    );
  }

  static TextStyle? display3(BuildContext context) {
    return GoogleFonts.openSans(
        textStyle: Theme.of(context).textTheme.headline2);
  }

  static TextStyle? display2(BuildContext context) {
    return GoogleFonts.openSans(
        textStyle: Theme.of(context).textTheme.headline3);
  }

  static TextStyle? display1(BuildContext context) {
    return GoogleFonts.openSans(
      color: Colors.white,
        textStyle: Theme.of(context).textTheme.headline4);
  }

  static TextStyle? headline(BuildContext context) {
    return GoogleFonts.openSans(
      color: Colors.white,
        textStyle: Theme.of(context).textTheme.headline5);
  }

  static TextStyle? title(BuildContext context) {
    return GoogleFonts.openSans(
        color: Colors.white, textStyle: Theme.of(context).textTheme.headline6);
  }

  static TextStyle medium(BuildContext context) {
    return GoogleFonts.openSans(
      color: Colors.white,
        textStyle:
            Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18));
  }

  static TextStyle? subhead(BuildContext context) {
    return GoogleFonts.openSans(
      color: Colors.white,
        textStyle: Theme.of(context).textTheme.subtitle1);
  }

  static TextStyle? body2(BuildContext context) {
    return GoogleFonts.openSans(
        color: Colors.white,
        textStyle: Theme.of(context).textTheme.bodyText1);
  }

  static TextStyle? body1(BuildContext context) {
    return GoogleFonts.openSans(
      color: Colors.white,
        textStyle: Theme.of(context).textTheme.bodyText2);
  }

  static TextStyle? caption(BuildContext context) {
    return GoogleFonts.openSans(
      color: Colors.white,
      textStyle: Theme.of(context).textTheme.caption);
  }

  static TextStyle? button(BuildContext context) {
    return GoogleFonts.openSans(
      color: Colors.white,
      fontWeight: FontWeight.bold,
        textStyle:
            Theme.of(context).textTheme.button!.copyWith(letterSpacing: 1));
  }

  static TextStyle? subtitle(BuildContext context) {
    return GoogleFonts.openSans(
      color: Colors.white,
        textStyle: Theme.of(context).textTheme.subtitle2);
  }

  static TextStyle? overline(BuildContext context) {
    return GoogleFonts.openSans(
      color: Colors.white,
        textStyle: Theme.of(context).textTheme.overline);
  }
}
