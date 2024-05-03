import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/feature/employee/profile/profile_page.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/visitor_select_employee_page.dart';
import 'package:igt_e_pass_app/feature/visitor/checkout/checkout_scanner_page.dart';
import 'package:igt_e_pass_app/feature/visitor/history/visitor_history_page.dart';
import 'package:igt_e_pass_app/feature/visitor/scan/scanner_page.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';
import '../../../components/build_bg_image.dart';
import '../../employee/home/component/build_card.dart';
import '../here_before/visitor_phone_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const Body();
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String userName = "";

  @override
  void initState() {
    getUserInfo().then((value) {
      userName = "${value.firstName ?? ''} ${value.lastName ?? ''}";
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Positioned.fill(child: BuildBgImage()),
      CustomScrollView(slivers: [
        SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: GestureDetector(
                onTap: () => Nav.push(const ProfilePage(isButtonBack: true)),
                child: Text("${AppLocalizations.of(context)!.hello} $userName",
                    style: MyText.title(context)!
                        .copyWith(fontWeight: FontWeight.bold))),
            actions: [
              IconButton(
                  splashRadius: 25,
                  tooltip: AppLocalizations.of(context)!.historyVisitor,
                  onPressed: () =>
                      Nav.push(const VisitorHistoryPage(), context: context),
                  icon: const Icon(Icons.history_rounded, size: 30)),
              IconButton(
                  splashRadius: 25,
                  tooltip: AppLocalizations.of(context)!.setting,
                  onPressed: () => Nav.push(
                      const ProfilePage(isButtonBack: true),
                      context: context),
                  icon: const Icon(Icons.settings_rounded, size: 30)),
            ]),
        SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          AppLocalizations.of(context)!
                              .vistors_pass_managerment,
                          style: MyText.headline(context)?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(AppLocalizations.of(context)!.welcome_pls_tap_button,
                          style: MyText.subtitle(context))
                    ]))),

        /// card
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
        SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  BuildCardItem(
                      name: AppLocalizations.of(context)!.scan_qr,
                      image: 'assets/icons/scanner.png',
                      onTap: () => Nav.push(const ScannerPage())),
                  BuildCardItem(
                      image: "assets/icons/checkin.png",
                      name: AppLocalizations.of(context)!.vistor_check_in,
                      onTap: () => Nav.push(const VisitorSelectEmployeePage())),
                  BuildCardItem(
                      image: "assets/icons/clock.png",
                      name: AppLocalizations.of(context)!.been_here_before,
                      onTap: () => Nav.push(const VisitorPhonePage())),
                  BuildCardItem(
                      image: "assets/icons/checkout.png",
                      name: AppLocalizations.of(context)!.checkout,
                      onTap: () => Nav.push(const CheckoutScannerPage()))
                ]))
      ])
    ]));
  }

  BoxDecoration containerDecoration({bool isBorderRadius = false}) {
    return BoxDecoration(
        borderRadius: isBorderRadius ? BorderRadius.circular(30.0) : null,
        gradient: const LinearGradient(
            colors: [Color(0xFF00B4d8), Color(0xFF03045e)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter));
  }
}
