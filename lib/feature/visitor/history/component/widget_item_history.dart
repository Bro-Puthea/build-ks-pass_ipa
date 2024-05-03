import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/utils/extension.dart';
import '../../../../components/my_cache_network_image.dart';
import '../../../../data/model/vistor/vistors_model.dart';
import '../../../../styles/my_text.dart';
import '../../../../utils/date_utils.dart';
import '../../../../utils/my_navigator.dart';
import '../../../employee/visitor/visitor_info_page.dart';

class WidgetItemHistoryVisitor extends StatelessWidget {
  final Visitors data;

  const WidgetItemHistoryVisitor({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.1 + 20,
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () => Nav.push(VisitorInfoPage(data: data)),
          splashColor: const Color.fromARGB(0, 7, 4, 4),
          highlightColor: Colors.transparent,
          child: Row(children: [
            /// image
            Flexible(
                flex: 2,
                child: CircleAvatar(
                    radius: 53,
                    backgroundColor: Colors.white10,
                    child: CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                            child: MyCachedNetworkImage(
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                imageUrl: data.image ?? ''))))),
            Container(width: 5),

            /// info
            Expanded(
                flex: 5,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(
                                child: Text(data.visitorName ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: MyText.body2(context)!.copyWith(
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w500))),
                            Container(width: 10),
                            GestureDetector(
                                onTap: () => makeCall(data.phone ?? '0'),
                                child: Text(AppLocalizations.of(context)!.call,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: MyText.body2(context)!.copyWith(
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w500)))
                          ]),
                          const Spacer(),
                          Row(children: [
                            Text('${AppLocalizations.of(context)?.checkin}: ',
                                style: MyText.caption(context)!.copyWith(
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400)),
                            Text(DateUtil.formatDate(data.checkIn ?? '', false),
                                style: MyText.caption(context)!.copyWith(
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.bold))
                          ]),
                          Container(height: 5),
                          Row(children: [
                            Text('${AppLocalizations.of(context)?.checkout}: ',
                                style: MyText.caption(context)!.copyWith(
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400)),
                            Text(
                                DateUtil.formatDate(data.checkOut ?? '', false),
                                style: MyText.caption(context)!.copyWith(
                                    letterSpacing: 0.5,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold))
                          ])
                        ])))
          ])));
}
