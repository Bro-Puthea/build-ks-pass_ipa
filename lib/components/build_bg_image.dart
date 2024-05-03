import 'package:flutter/material.dart';

class BuildBgImage extends StatelessWidget {
  const BuildBgImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(children: [
      Image.asset("assets/images/color_bg.png",
          fit: BoxFit.fill, width: width, height: height),
      Center(
          child: Image.asset("assets/images/logo.png",
              color: const Color(0xFF117898).withOpacity(0.50)))
    ]);
  }
}

/*          Positioned.fill(
          child: Image.asset(
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height + // total height
                  kToolbarHeight + // top AppBar height
                  MediaQuery.of(context).padding.top + // top padding
                  kBottomNavigationBarHeight,
              "assets/images/background.png")),*/
