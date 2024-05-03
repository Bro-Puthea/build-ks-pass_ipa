import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import '../styles/my_text.dart';

class BuildActiveButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;

  const BuildActiveButton({Key? key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: onTap,
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(title ?? AppLocalizations.of(context)!.continued,
              style: MyText.button(context)!.copyWith())));
}

class BuildCancelButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final Color? color;

  const BuildCancelButton({Key? key, this.title, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: onTap ?? () => Nav.pop(context: context),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(width: 2.0, color: color ?? Colors.red)),
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(title ?? AppLocalizations.of(context)!.cancel,
              style: MyText.button(context)
                  ?.copyWith(color: color ?? Colors.red))));
}
