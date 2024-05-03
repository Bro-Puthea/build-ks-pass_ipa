import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/data/model/vistor/visitor_checkout_model.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/providers/checkin_provider.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import 'package:provider/provider.dart';
import '../../../components/my_cache_network_image.dart';
import '../../../resource/constant.dart';
import '../../../utils/general_utils.dart';

class WaitingConfirmPage extends StatelessWidget {
  final DataCheckIn data;

  const WaitingConfirmPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CheckinProvider(), child: Waiting(data: data));
  }
}

// ignore: must_be_immutable
class Waiting extends StatefulWidget {
  DataCheckIn data;

  Waiting({super.key, required this.data});

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  late Timer _timer;
  late Timer _timerCheck;
  late bool _isSecurity;
  int _start = Const.waitSec;
  int _min = Const.waitMin;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() => timer.cancel());
      } else {
        setState(() => _start--);
        switch (_start) {
          case 180:
            _min = 3;
            break;
          case 120:
            _min = 2;
            break;
          case 60:
            _min = 1;
            break;
          case 0:
            _min = 0;
            break;
        }
      }
    });
  }

  void _checkAllow() {
    final state = Provider.of<CheckinProvider>(context, listen: false);
    _timerCheck = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      state.getAllowed(widget.data.id ?? '').whenComplete(() {
        if (state.allow.allowed == '1') {
          _start = 0;
          _isSecurity = false;
          widget.data.allowed = '1';
          widget.data.allowBy = state.allow.name ?? '';
          timer.cancel();
          setState(() {});
        }
      });
    });
  }

  @override
  void initState() {
    _isSecurity = widget.data.isSecurity ?? true;
    if (widget.data.allowed == '1') _start = 0;
    if (_isSecurity) _startTimer();
    _checkAllow();
    super.initState();
  }

  @override
  void dispose() {
    if (_isSecurity) _timer.cancel();
    _timerCheck.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        title: AppLocalizations.of(context)!.waitingConfirm,
        backgroundColor: AppColors.primaryGreyText,
        body: SingleChildScrollView(
            child: Column(children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              margin: const EdgeInsets.all(25),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipOval(
                            child: SizedBox.fromSize(
                                size: const Size.fromRadius(50),
                                child: MyCachedNetworkImage(
                                    imageUrl: widget.data.image ?? ''))),
                        Text(widget.data.visitorName ?? '',
                            style: MyText.subhead(context)?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(
                            "${AppLocalizations.of(context)!.phone}: ${widget.data.phone}",
                            style: MyText.body1(context)
                                ?.copyWith(color: Colors.black)),
                        Text(
                            "${AppLocalizations.of(context)!.id}: ${widget.data.visitorCode}",
                            style: MyText.body1(context)
                                ?.copyWith(color: Colors.black)),
                        Text(AppLocalizations.of(context)!.visitedTo,
                            style: MyText.title(context)?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(
                            "${AppLocalizations.of(context)!.host} : ${widget.data.empName}",
                            style: MyText.subhead(context)?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),

                        const Divider(thickness: 2, color: Colors.black),
                        Visibility(
                            visible: !_isSecurity,
                            child: Text(
                                widget.data.allowed == '1'
                                    ? AppLocalizations.of(context)!
                                        .allowSuccessMsg
                                    : AppLocalizations.of(context)!
                                        .confirmAllowMsg,
                                textAlign: TextAlign.center,
                                style: MyText.subhead(context)
                                    ?.copyWith(color: Colors.black))),
                        Visibility(
                            visible: widget.data.allowed == '1',
                            child: Text(
                              '${AppLocalizations.of(context)!.allowBy}: ${widget.data.allowBy}',
                              style: MyText.subhead(context)?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),

                        /// timer for security
                        Visibility(
                            visible: _isSecurity,
                            child: Text(
                                AppLocalizations.of(context)!.waitingTime,
                                style: MyText.title(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        Visibility(
                            visible: _isSecurity,
                            child: Text(
                                '${Const.waitMin} ${AppLocalizations.of(context)!.minutes}',
                                style: MyText.subhead(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        Visibility(
                            visible: _isSecurity,
                            child: Text.rich(TextSpan(
                                text:
                                    "$_min ${AppLocalizations.of(context)!.minutesOf}",
                                style: MyText.body1(context)
                                    ?.copyWith(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: "\t\t$_start\t\t",
                                      style: MyText.subhead(context)?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          AppLocalizations.of(context)!.seconds,
                                      style: MyText.body1(context)
                                          ?.copyWith(color: Colors.black))
                                ])))
                      ]))),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              margin: const EdgeInsets.all(25),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  child: Row(children: [
                    _buildButton(
                        AppLocalizations.of(context)!.skip,
                        () => Navigator.popUntil(
                            context, (predicate) => predicate.isFirst)),
                    widget.data.allowed != '1'
                        ? _isSecurity
                            ? _buildButton(
                                AppLocalizations.of(context)!.allowIn,
                                _start == 0 ? allow : null)
                            : _buildButton(
                                AppLocalizations.of(context)!.allowIn, allow)
                        : _buildButton(
                            AppLocalizations.of(context)!.allowIn,
                            () => Navigator.popUntil(
                                context, (predicate) => predicate.isFirst))
                  ]))),
          const SizedBox(height: 100)
        ])));
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

  Widget _buildButton(String title, Function()? onTap) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
                onPressed: onTap,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(title,
                        style: MyText.button(context)!.copyWith())))));
  }
}
