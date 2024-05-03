import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/styles/colors.dart';

class MyLoadingWidget extends StatelessWidget {
  final bool center;

  const MyLoadingWidget({
    Key? key,
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:38),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryText,
          )
          ),
        ),
    );
  }
}
