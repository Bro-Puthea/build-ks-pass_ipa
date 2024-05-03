import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/utils/extension.dart';
import '../../../../styles/colors.dart';
import '../../../../styles/my_text.dart';

class WidgetInfoItem extends StatelessWidget {
  final IconData icon;
  final String? title, subtitle;
  final bool isEdite;
  final Function()? onTap;

  const WidgetInfoItem(
      {Key? key,
      required this.icon,
      this.title,
      this.subtitle,
      this.isEdite = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(30)),
      child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                /// icon
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.blueGrey.shade100),
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(top: 5),
                    child: Icon(icon,
                        color: AppColors.primaryBackground, size: 24)),
                Container(width: 15),

                /// string
                isEdite
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(title ?? 'N/A',
                            overflow: TextOverflow.fade,
                            style: MyText.body2(context)!.copyWith(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w500)))
                    : Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(title ?? 'N/A',
                                style: MyText.body1(context)!.copyWith(
                                    color: Colors.blueGrey,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400)),
                            Container(height: 5),
                            Text(subtitle ?? 'N/A',
                                maxLines: null,
                                overflow: TextOverflow.fade,
                                style: MyText.body2(context)!.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500))
                          ])),

                /// arrow
                isEdite ? const Spacer() : const SizedBox.shrink(),
                Visibility(
                    visible: isEdite,
                    child: const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Icon(Icons.arrow_forward_ios,
                            color: Colors.white, size: 20)))
              ]))));
}
