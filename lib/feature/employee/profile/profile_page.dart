import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/components/build_button.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/feature/employee/chang_password/change_password_page.dart';
import 'package:igt_e_pass_app/feature/employee/profile/provider/profile_provider.dart';
import 'package:igt_e_pass_app/feature/employee/profile/update_profile_page.dart';
import 'package:igt_e_pass_app/feature/employee/visitor/component/widget_info_item.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';
import 'package:provider/provider.dart';
import '../../../components/my_scaffold.dart';
import '../../../data/model/user_login_model.dart';
import '../../../l10n/providers/local_provider.dart';
import '../../../styles/my_text.dart';
import '../../../utils/my_navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  final bool isButtonBack;

  const ProfilePage({Key? key, required this.isButtonBack}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: Body(isButtonBack: isButtonBack));
}

class Body extends StatefulWidget {
  final bool isButtonBack;

  const Body({Key? key, required this.isButtonBack}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var userData = User();
  String codeLang = "";

  @override
  void initState() {
    getLangCode().then((value) {
      setState(() {});
      codeLang = value.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Consumer<ProfileProvider>(
      builder: (context, state, _) => MyScaffold(
          title: AppLocalizations.of(context)!.personal_info,
          centerTitle: !widget.isButtonBack,
          leadType:
              widget.isButtonBack ? AppBarBackType.back : AppBarBackType.none,
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(child: Container(height: 20)),

            /// avatar
            SliverToBoxAdapter(
                child: Center(
                    child: Column(children: [
              CircleAvatar(
                  radius: 53,
                  backgroundColor: Colors.white10,
                  backgroundImage: NetworkImage(state.userData.imageUrl ?? '')),
              const SizedBox(height: 10),
              Text(
                  "${state.userData.firstName ?? ''} ${state.userData.lastName ?? ''}",
                  style: MyText.title(context))
            ]))),

            /// list info
            SliverToBoxAdapter(child: Container(height: 20)),

            SliverToBoxAdapter(
                child: WidgetInfoItem(
                    icon: Icons.supervised_user_circle_rounded,
                    title: AppLocalizations.of(context)!.username,
                    subtitle:
                        "${state.userData.firstName ?? ''} ${state.userData.lastName ?? ''}")),

            SliverToBoxAdapter(
                child: WidgetInfoItem(
                    icon: Icons.email_rounded,
                    title: AppLocalizations.of(context)!.email,
                    subtitle: state.userData.email)),

            SliverToBoxAdapter(
                child: WidgetInfoItem(
                    icon: Icons.phone_rounded,
                    title: AppLocalizations.of(context)!.phone,
                    subtitle: state.userData.phone)),

            SliverToBoxAdapter(
                child: WidgetInfoItem(
                    icon: Icons.location_on_sharp,
                    title: AppLocalizations.of(context)!.address,
                    subtitle: state.userData.address)),

            SliverToBoxAdapter(
                child: WidgetInfoItem(
                    icon: Icons.language,
                    title: AppLocalizations.of(context)!.language,
                    isEdite: true,
                    onTap: () => _showBottomSheet(context))),

            SliverToBoxAdapter(
                child: WidgetInfoItem(
                    icon: Icons.password,
                    title: AppLocalizations.of(context)!.change_password,
                    isEdite: true,
                    onTap: () =>
                        Nav.push(const ChangPasswordPage(), context: context))),

            SliverToBoxAdapter(
                child: WidgetInfoItem(
                    icon: Icons.edit_attributes_rounded,
                    title:
                        "${AppLocalizations.of(context)!.update} ${AppLocalizations.of(context)!.my_profile}",
                    onTap: () =>
                        Nav.push(const UpdateProfilePage(), context: context)
                            .whenComplete(() => state.getProfilePreview()),
                    isEdite: true)),

            SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: BuildActiveButton(
                        title: AppLocalizations.of(context)!.sign_out,
                        onTap: () => GeneralUtil.showAlertDialog(
                            title: AppLocalizations.of(context)!.sign_out,
                            subTittle: AppLocalizations.of(context)!
                                .do_you_want_to_logout,
                            positiveButtonTitle:
                                AppLocalizations.of(context)!.continued,
                            negativeButtonTitle:
                                AppLocalizations.of(context)!.cancel,
                            onPositiveButton: () =>
                                GeneralUtil.signOut(context))))),

            SliverToBoxAdapter(child: Container(height: 20))
          ])));

  void _showBottomSheet(BuildContext context) {
    final state = Provider.of<LocaleProvider>(context, listen: false);

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(25), topStart: Radius.circular(25))),
        builder: (context) => GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
                color: Colors.transparent,
                child: GestureDetector(
                    onTap: () {},
                    child: DraggableScrollableSheet(
                        initialChildSize: 0.4,
                        minChildSize: 0.2,
                        maxChildSize: 0.75,
                        builder: (_, controller) {
                          return Container(
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0))),
                              child: Column(children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    height: 5,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        color: AppColors.textFieldUnFocusColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                                Expanded(child: StatefulBuilder(
                                    builder: (context, setState) {
                                  return ListView(
                                      controller: controller,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            child: Text(
                                                "${AppLocalizations.of(context)!.select} ${AppLocalizations.of(context)!.language}",
                                                style: MyText.title(context)
                                                    ?.copyWith())),
                                        RadioListTile(
                                            title: Text('English',
                                                style:
                                                    MyText.subtitle(context)),
                                            value: 'en',
                                            groupValue: codeLang,
                                            onChanged: (value) {
                                              setState(() {});
                                              codeLang = value.toString();
                                              setLangCode(value.toString());
                                              state.setLocale(
                                                  Locale.fromSubtags(
                                                      languageCode:
                                                          value.toString()));
                                              Navigator.of(context).pop();
                                            }),
                                        RadioListTile(
                                            title: Text('ខ្មែរ',
                                                style: MyText.body1(context)),
                                            value: 'km',
                                            groupValue: codeLang,
                                            onChanged: (value) {
                                              setState(() {});
                                              codeLang = value.toString();
                                              setLangCode(value.toString());
                                              state.setLocale(
                                                  Locale.fromSubtags(
                                                      languageCode:
                                                          value.toString()));
                                              Navigator.of(context).pop();
                                            }),
                                        RadioListTile(
                                            title: Text('中国人',
                                                style: MyText.body1(context)),
                                            value: 'zh',
                                            groupValue: codeLang,
                                            onChanged: (value) {
                                              setState(() {});
                                              codeLang = value.toString();
                                              setLangCode(value.toString());
                                              state.setLocale(
                                                  Locale.fromSubtags(
                                                      languageCode:
                                                          value.toString()));
                                              Navigator.of(context).pop();
                                            })
                                      ]);
                                }))
                              ]));
                        })))));
  }
}
