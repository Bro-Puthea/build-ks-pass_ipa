import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/visitor_register_page.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AttendanceBody();
  }
}

class AttendanceBody extends StatefulWidget {
  AttendanceBody({super.key});

  @override
  State<AttendanceBody> createState() => _AttendanceBodyState();
}

class _AttendanceBodyState extends State<AttendanceBody> {
  bool isClockin = true;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "Employee",
      centerTitle: true,
      leadType: AppBarBackType.none,
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/icons/profile.png"),
                      ),
                      SizedBox(
                          child: Column(
                        children: [
                          Text(
                            'Good Morning',
                            style: MyText.title(context),
                          ),
                          Text(
                            "Chey",
                            style: MyText.title(context)
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildListTile(context,
                      title: "6:06AM", subtitle: '24/10/2024'),
                  const SizedBox(height: 15),
                  EntryField(
                    label: "Work from",
                    hint: "Enter work from",
                  ),
                  const SizedBox(height: 20),
                  buildCardItem(
                      isClockin: isClockin,
                      onTap: () {
                        setState(() {});
                        isClockin = !isClockin;
                        if (isClockin) {
                          GeneralUtil.showSnackBarMessage(
                              isSuccess: true, message: "Clock out successful");
                        } else {
                          GeneralUtil.showSnackBarMessage(
                              isSuccess: true, message: "Clock in successful");
                        }
                      }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildListTile(context,
                          title: "Clock out", subtitle: 'N/A'),
                      _buildListTile(context,
                          title: "Clock in", subtitle: 'N/A'),
                    ],
                  ),
                ],
              ))),
    );
  }

  Widget _buildListTile(BuildContext context,
      {String title = '', String subtitle = ''}) {
    return SizedBox(
        child: Column(
      children: [
        Text(
          title,
          style: MyText.title(context)?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: MyText.subtitle(context),
        ),
      ],
    ));
  }

  Widget buildCardItem({Function? onTap, bool isClockin = false}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: MediaQuery.of(Nav.ctx).size.width,
        height: MediaQuery.of(Nav.ctx).size.height / 4,
        decoration: BoxDecoration(
          color: isClockin ? AppColors.primaryColor : Colors.red,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 0.6), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Icon(
                isClockin ? Icons.login : Icons.logout,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              isClockin ? "Clock in" : "Clock out",
              style: MyText.subhead(Nav.ctx)!
                  .copyWith(fontWeight: FontWeight.w900, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
