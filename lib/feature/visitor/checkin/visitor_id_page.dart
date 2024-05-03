import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/build_qr_image.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/data/model/vistor/visitor_checkout_model.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/providers/checkin_provider.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/waiting_confirm_page.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../../components/my_cache_network_image.dart';
import '../../../utils/general_utils.dart';
import '../../../utils/my_navigator.dart';

class VisitorIdPage extends StatelessWidget {
  final DataCheckIn data;
  final bool autoAllow;

  const VisitorIdPage({super.key, required this.data, this.autoAllow = false});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => CheckinProvider(),
      child: Body(data: data, autoAllow: autoAllow));
}

class Body extends StatefulWidget {
  final DataCheckIn data;
  final bool autoAllow;

  const Body({super.key, required this.data, this.autoAllow = false});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String userName = "";
  String email = "";
  ScreenshotController controller = ScreenshotController();

  @override
  void initState() {
    getUserInfo().then((value) {
      setState(() {});
      userName = "${value.firstName} ${value.lastName}";
      email = value.email ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: controller,
        child: WillPopScope(
            onWillPop: () async {
              Navigator.popUntil(context, (predicate) => predicate.isFirst);
              return true;
            },
            child: MyScaffold(
                centerTitle: true,
                leadType: AppBarBackType.none,
                title: AppLocalizations.of(context)!.vistor_id,
                backgroundColor: AppColors.primaryGreyText,
                body: SingleChildScrollView(
                    child: widget.data.block == "blocked"
                        ? Container()
                        : Column(children: [
                            Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                margin: const EdgeInsets.all(25),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Container(
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.width,
                                    height: 500,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipOval(
                                              child: SizedBox.fromSize(
                                                  size:
                                                      const Size.fromRadius(50),
                                                  child: MyCachedNetworkImage(
                                                      imageUrl:
                                                          widget.data.image ??
                                                              ''))),
                                          Text(widget.data.visitorName ?? '',
                                              style: MyText.subhead(context)
                                                  ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          Text(
                                              "${AppLocalizations.of(context)!.phone}: ${widget.data.phone}",
                                              style: MyText.body1(context)
                                                  ?.copyWith(
                                                      color: Colors.black)),
                                          Text(
                                              "${AppLocalizations.of(context)!.id}: ${widget.data.visitorCode}",
                                              style: MyText.body1(context)
                                                  ?.copyWith(
                                                      color: Colors.black)),
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .visitedTo,
                                              style: MyText.title(context)
                                                  ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          Text(
                                              "${AppLocalizations.of(context)!.host} : ${widget.data.empName}",
                                              style: MyText.subhead(context)
                                                  ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          const Divider(
                                              thickness: 2,
                                              color: Colors.black),
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .visitedPass,
                                              style: MyText.title(context)
                                                  ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          Text(userName,
                                              style: MyText.subhead(context)
                                                  ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          Text(
                                              "${AppLocalizations.of(context)!.email}: $email",
                                              style: MyText.body1(context)
                                                  ?.copyWith(
                                                      color: Colors.black))
                                        ]))),
                            widget.data.isCheckIn ?? true
                                ? BuildQRImage(
                                    qr: widget.data.visitorCode ?? '',
                                    color: Colors.white,
                                    controller: controller,
                                    isCheckIn: false)
                                : const SizedBox.shrink(),
                            const SizedBox(height: 100)
                          ])),
                bottomButton: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () => widget.autoAllow
                                  ? allow()
                                  : widget.data.isCheckIn ?? true
                                      ? Nav.push(
                                          WaitingConfirmPage(data: widget.data))
                                      : Navigator.popUntil(context,
                                          (predicate) => predicate.isFirst),
                              child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      AppLocalizations.of(context)!.continued,
                                      style:
                                          MyText.button(context)!.copyWith())))
                        ])))));
  }

  void allow() {
    final state = Provider.of<CheckinProvider>(context, listen: false);
    state.toAllowIn(widget.data.id ?? '').then((value) {
      if (state.resultResponse.success == "true") {
        GeneralUtil.showSnackBarMessage(
            isSuccess: true, message: state.resultResponse.message);
        Navigator.popUntil(context, (predicate) => predicate.isFirst);
      } else {
        GeneralUtil.showSnackBarMessage(isSuccess: false);
      }
    });
  }
}
