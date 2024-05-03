import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/build_button.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/camera_page.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/visitor_id_page.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:provider/provider.dart';
import '../../../data/model/visitor_param.dart';
import '../../../data/model/vistor/visitor_checkout_model.dart';
import '../../../resource/constant.dart';
import '../../../utils/preference_helper.dart';
import 'providers/checkin_provider.dart';

class TakePhotoPage extends StatelessWidget {
  final VisitorParam param;
  final bool autoAllow;

  const TakePhotoPage(
      {super.key, required this.param, required this.autoAllow});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => CheckinProvider(),
      child: Body(param: param, autoAllow: autoAllow));
}

class Body extends StatefulWidget {
  final VisitorParam param;
  final bool autoAllow;

  const Body({super.key, required this.param, required this.autoAllow});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  XFile? picture;

  @override
  Widget build(BuildContext context) => MyScaffold(
      title: AppLocalizations.of(context)?.take_photo,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.primaryCardColor,
                            child: picture != null
                                ? Image.file(File(picture!.path),
                                    fit: BoxFit.cover)
                                : const Icon(Icons.add_photo_alternate_rounded,
                                    size: 100, color: Colors.white60))),
                    const SizedBox(height: 30),
                    Visibility(
                        visible: true,
                        child: ElevatedButton(
                            onPressed: () async => await availableCameras()
                                .then((value) =>
                                    Nav.push(CameraPage(cameras: value))
                                        .then((value) {
                                      picture = value;
                                      setState(() {});
                                    })),
                            child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                    AppLocalizations.of(context)!.take_photo,
                                    style:
                                        MyText.button(context)!.copyWith()))))
                  ])))),
      bottomButton: Padding(
          padding: const EdgeInsets.all(15),
          child: BuildActiveButton(onTap: add)));

  void add() {
    final state = Provider.of<CheckinProvider>(context, listen: false);
    state
        .registerNewVisitor(file: picture?.path, params: _mapParam())
        .then((value) {
      if (state.resultResponse.status == "success") {
        GeneralUtil.showSnackBarMessage(
            isSuccess: true, message: state.resultResponse.message);
        state
            .info(state.resultResponse.id ?? '')
            .whenComplete(() => Nav.push(VisitorIdPage(
                autoAllow: widget.autoAllow,
                data: DataCheckIn(
                  visitorName: state.data.visitorName ?? '',
                  phone: state.data.phone ?? '',
                  image: state.data.image ?? '',
                  empName: state.data.empName ?? '',
                  visitorCode: state.data.visitorCode ?? '',
                  id: state.resultResponse.id ?? '', // visitor_id
                ))));
      } else {
        GeneralUtil.showSnackBarMessage(
            isSuccess: false, message: state.resultResponse.message);
      }
    });
  }

  Map<String, String> _mapParam() => {
        Const.visitorName: widget.param.visitorName ?? '',
        Const.numOfVisitor: widget.param.visitorNumber ?? '',
        Const.phone: widget.param.phone ?? '',
        Const.companyName: widget.param.companyName ?? '',
        Const.vehicleNumber: widget.param.vehicleNumber ?? '',
        Const.isTypeOfId: widget.param.isTypeOfId ?? '',
        Const.typeOfId: widget.param.typeOfId ?? '',
        Const.typeOfIdNumber: widget.param.typeOfIdNumber ?? '',
        Const.isVisitorCard: widget.param.isVisitorCard ?? '',
        Const.cardId: widget.param.cardId ?? '',
        Const.departmentId: widget.param.departmentId ?? '',
        Const.empId: widget.param.employeeId ?? '',
        Const.purpose: widget.param.purpose ?? '',
        Const.notifyTo: widget.param.notifyTo ?? '',
        Const.createdBy: PrefsHelper.getString(Const.userId) ?? '',
        Const.preRegisterId: widget.param.preRegisterId ?? ''
      };
}
