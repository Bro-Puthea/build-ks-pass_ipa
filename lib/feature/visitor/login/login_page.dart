import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/build_button.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/data/config/init_onesignal.dart';
import 'package:igt_e_pass_app/data/model/user_login_model.dart';
import 'package:igt_e_pass_app/feature/employee/main_page/main_page.dart';
import 'package:igt_e_pass_app/feature/visitor/login/provider/login_provider.dart';
import 'package:igt_e_pass_app/feature/visitor/main/main_page.dart';
import 'package:igt_e_pass_app/resource/constant.dart';
import 'package:igt_e_pass_app/utils/extension.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';
import 'package:provider/provider.dart';
import '../../../utils/preference_helper.dart';
import '../../../utils/validator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    initOneSignal();
    return ChangeNotifierProvider(
        create: (_) => LoginProvider(), child: const Body());
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  void initState() {
    initOneSignal();
    if (Const.isDebug) {
      _phoneController.text = "093550939";
      _passwordController.text = "Ab123456";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initOneSignal();
    Nav.ctx = context;
    return MyScaffold(
        leadType: AppBarBackType.none,
        title: AppLocalizations.of(context)!.login,
        centerTitle: true,
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(children: [
                      EntryField(
                          keyboardType: TextInputType.phone,
                          label: AppLocalizations.of(context)!.phone,
                          hint: AppLocalizations.of(context)!.phone,
                          image: 'assets/icons/ic_phone.png',
                          controller: _phoneController,
                          validator: Validator.validatePhoneNumber),
                      const SizedBox(height: 5),
                      EntryField(
                          label: AppLocalizations.of(context)!.password,
                          hint: AppLocalizations.of(context)!.password,
                          image: 'assets/icons/id1.png',
                          maxLines: 1,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: passwordVisible,
                          validator: (value) {
                            String t = value ?? '';
                            return t.trim().isNotEmpty
                                ? null
                                : AppLocalizations.of(context)!.pw_is_required;
                          },
                          suffixIcon: passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixIconAction: () => setState(
                              () => passwordVisible = !passwordVisible))
                    ])))),
        bottomButton: Padding(
            padding: const EdgeInsets.all(50),
            child: BuildActiveButton(onTap: _doLogIn)));
  }

  Future _doLogIn() async {
    final state = Provider.of<LoginProvider>(context, listen: false);
    await initOneSignal();
    if ((_formKey.currentState as FormState).validate()) {
      state
          .doLogin(
              identity: _phoneController.text.trim(),
              password: _passwordController.text)
          .whenComplete(() {
        if (state.userData.status == "success") {
          setUserInfo(state.userData.data ?? User());
          setIsLogin(true);
          setCustomerId(state.userData.data?.id ?? '');
          setGroupId(state.userData.data?.groupId ?? '');
          setGroupName(state.userData.data?.groupName ?? '');

          PrefsHelper.setString(
              Const.departmentId, state.userData.data?.departmentId ?? '');
          PrefsHelper.setString(
              Const.department, state.userData.data?.departmentName ?? '');
          PrefsHelper.setString(Const.empId, state.userData.data?.empId ?? '');
          PrefsHelper.setString(
              Const.employee, state.userData.data?.empName ?? '');

          GeneralUtil.showSnackBarMessage(
              isSuccess: true,
              context: context,
              message: state.userData.message);
          if (state.userData.data?.groupName == Const.security) {
            Nav.pushAndRemove(const VisitorsMainPage(), context: context);
          } else if (state.userData.data?.groupName == Const.employee) {
            Nav.pushAndRemove(const EmployeeMainPage(), context: context);
          }
        } else {
          GeneralUtil.showSnackBarMessage(
              isSuccess: false,
              context: context,
              message: (state.userData.message ?? '').removeAllHtmlTags());
        }
      });
    }
  }
}
