import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/feature/visitor/scan/providers/visitor_check_in_provider.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../checkin/visitor_select_employee_page.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => VistorCheckInProvider(), child: const Body());
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Barcode? result;
  bool _isFlashOn = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final key = GlobalKey<ScaffoldState>();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        body: Column(children: [
          Expanded(
              child: Stack(alignment: AlignmentDirectional.center, children: [
            Positioned.fill(child: _buildQrView(context)),
            _buildFlash(),
            Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                    onPressed: () => Nav.pop(context: context),
                    icon: const Icon(Icons.arrow_back_rounded),
                    iconSize: 30,
                    color: Colors.white))
          ]))
        ]));
  }

  Positioned _buildFlash() {
    return Positioned(
        bottom: 66,
        child: Align(
            alignment: Alignment.center,
            child: Container(
                color: Colors.transparent,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(20),
                                        backgroundColor:
                                            Colors.white.withOpacity(0.3)),
                                    onPressed: () async {
                                      await controller?.toggleFlash();
                                      setState(() => _isFlashOn = !_isFlashOn);
                                    },
                                    child: FutureBuilder(
                                        future: controller?.getFlashStatus(),
                                        builder: (context, snapshot) {
                                          return Icon(
                                              _isFlashOn
                                                  ? Icons.flashlight_on
                                                  : Icons.flashlight_off,
                                              size: 28.8);
                                        })))
                          ])
                    ]))));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 330.0
        : 330.0;
    return QRView(
        key: qrKey,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderRadius: 8,
            borderLength: 25,
            borderWidth: 8,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        onQRViewCreated: (QRViewController controller) {
          setState(() {
            this.controller = controller;
          });
          controller.scannedDataStream.listen((scanData) {
            setState(() async {
              result = scanData;
              if (result != null) {
                await controller.pauseCamera();
                await doCheckIn(result?.code);
              }
            });
          });
        });
  }

  Future doCheckIn(String? code) async {
    final state = Provider.of<VistorCheckInProvider>(context, listen: false);
    await state.initData(code: code).whenComplete(() async {
      if (state.visitorCheckin.status == true) {
        await GeneralUtil.showSnackBarMessage(
                message: state.visitorCheckin.message)
            .whenComplete(() {
          Nav.pushAndRemove(VisitorSelectEmployeePage(
              data: state.visitorCheckin, autoAllow: true));
        });
        //} else if (state.visitorCheckin.status == false) {
      } else {
        await GeneralUtil.showSnackBarMessage(
            message: state.visitorCheckin.message, isSuccess: false);
        await controller?.resumeCamera();
      }
      /*else {
        GeneralUtil.showErrrDialog(
            title: "Block",
            subtitle: "This account have been bloked",
            onPositiveButton: () => Nav.pop(),
            onNegativeButton: () => Nav.pop());
      }*/
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No permisstion")),
      );
    }
  }
}
