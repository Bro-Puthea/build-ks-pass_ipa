import 'package:flutter/material.dart';
import '../../../../styles/my_text.dart';

class BuildCardItem extends StatelessWidget {
  final String? image;
  final String name;
  final String? total;
  final Function()? onTap;

  const BuildCardItem(
      {Key? key, this.image, required this.name, this.total, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      color: Colors.transparent.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
          onTap: onTap,
          highlightColor: Colors.transparent.withOpacity(0.4),
          splashColor: Colors.transparent,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(radius: 30, backgroundImage: AssetImage(image!)),
            Container(height: 10),
            Text(name,
                textAlign: TextAlign.center,
                style: MyText.caption(context)!.copyWith(
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Container(height: 5),
            total != null
                ? Text(total ?? '',
                    textAlign: TextAlign.center,
                    style: MyText.title(context)!.copyWith(
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))
                : const SizedBox.shrink()
          ])));
}
