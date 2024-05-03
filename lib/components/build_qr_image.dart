import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../styles/my_text.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildQRImage extends StatelessWidget {
  final String qr;
  final Color? color;
  final Function()? onTap;
  final ScreenshotController? controller;
  final bool isOnTap, isCheckIn;

  const BuildQRImage(
      {Key? key,
      required this.qr,
      this.color,
      this.onTap,
      this.controller,
      this.isOnTap = true,
      this.isCheckIn = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(30),
      child: Column(children: [
        /// qr
        _buildQR(context),

        /// button
        Visibility(
            visible: isOnTap,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: onTap ??
                        () async {
                          _saveAndShare(await controller!
                              .captureFromWidget(_buildQR(context)));
                        },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(AppLocalizations.of(context)!.share,
                            style: MyText.button(context)!.copyWith())))))
      ]));

  Widget _buildQR(BuildContext context) => Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: color ?? Colors.white,
      elevation: 0,
      child: QrImageView(
          data: qr,
          size: (MediaQuery.of(context).size.width < 400 ||
                  MediaQuery.of(context).size.height < 400)
              ? 280.0
              : 330.0,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(20),
          embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(80, 80)),
          gapless: true,
          version: QrVersions.auto));

  Future _saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}.png');
    file.writeAsBytes(bytes);
    final text = isCheckIn
        ? 'Hello! By the appointment we arranged to meet soon. You have to bring this QR code to our securities to scan you check in ✅\n'
        : 'Hello! After the appointment we have been met. You have to bring this QR code to our securities to scan you check out ✅\n';
    await Share.shareXFiles([XFile(file.path)], text: text);
  }
}
