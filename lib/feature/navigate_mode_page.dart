import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/feature/employee/main_page/main_page.dart';
import 'package:igt_e_pass_app/feature/visitor/main/main_page.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import '../../../components/my_app_bar.dart';
import '../../../components/my_scaffold.dart';
import '../../../styles/my_text.dart';

class NavigateModePage extends StatelessWidget {
  const NavigateModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Visitor();
  }
}

class Visitor extends StatefulWidget {
  const Visitor({Key? key}) : super(key: key);

  @override
  State<Visitor> createState() => _VisitorState();
}

class _VisitorState extends State<Visitor> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        title: 'E-Pass',
        centerTitle: true,
        leadType: AppBarBackType.none,
        body:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverToBoxAdapter(child: Container(height: 20)),

          /// card
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  children: [
                    buildCardItem(context,
                        color: Colors.black,
                        onTap: () => Nav.pushAndRemove(const EmployeeMainPage(), context: context),
                        name: 'Go to employee Epass feature',),
                    buildCardItem(context,
                        color: Colors.black,
                        onTap: ()=> Nav.pushAndRemove(const VisitorsMainPage(), context: context),
                        name: 'Go to vistor Epass feature')
                  ])),
        ]));
  }
}

Widget buildCardItem(BuildContext context,
    {name, Function? onTap, Color? color}) {
  return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: InkWell(
          onTap: () => onTap!(),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: color!),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 10),
                    Text(name,
                        textAlign: TextAlign.center,
                        style: MyText.body2(context)!.copyWith(
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Container(height: 5),
                  ]))));
}
