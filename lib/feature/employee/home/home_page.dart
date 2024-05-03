import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/build_bg_image.dart';
import 'package:igt_e_pass_app/feature/employee/home/component/build_card.dart';
import 'package:igt_e_pass_app/feature/employee/home/component/widget_item_visitor.dart';
import 'package:igt_e_pass_app/feature/employee/home/provider/dashbard_provider.dart';
import 'package:igt_e_pass_app/feature/employee/visitor/all_visitors_page.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:provider/provider.dart';
import '../../../styles/my_text.dart';
import '../pre_register/pre_register_page.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => DashboardProvider(), child: const Body());
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) => Consumer<DashboardProvider>(
      builder: (context, state, _) => Scaffold(
              body: Stack(children: [
            const Positioned.fill(child: BuildBgImage()),
            CustomScrollView(slivers: [
              SliverToBoxAdapter(child: Container(height: kToolbarHeight)),

              /// card
              SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      children: [
                        BuildCardItem(
                            total: state.data.totalPreRegister ?? '',
                            name:
                                AppLocalizations.of(context)!.todayAppointment,
                            image: 'assets/icons/person.png',
                            onTap: () => Nav.push(
                                const PreRegisterPage(isButtonBack: true))),
                        BuildCardItem(
                            total: state.data.totalVisitors ?? '',
                            name: AppLocalizations.of(context)!.todayVisitor,
                            image: 'assets/icons/persons.png',
                            onTap: () => Nav.push(
                                const AllVisitorsPage(isButtonBack: true)))
                      ])),

              /// entrance title
              SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(children: [
                        Text(AppLocalizations.of(context)?.vistors ?? '',
                            style: MyText.title(context)!.copyWith(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w500)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => Nav.push(
                                const AllVisitorsPage(isButtonBack: true)),
                            child: Text(
                                AppLocalizations.of(context)?.view_all ?? '',
                                style: MyText.caption(context)!.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500)))
                      ]))),

              /// list
              SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: state.isEmpty
                      ? SliverToBoxAdapter(
                          child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!.no_data_found,
                                  style: MyText.title(context))))
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, i) =>
                                  WidgetItemVisitor(data: state.list[i]),
                              childCount: state.list.length)))
            ])
          ])));
}
