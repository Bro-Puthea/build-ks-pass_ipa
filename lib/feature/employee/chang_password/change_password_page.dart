import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/build_button.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/resource/constant.dart';
import 'package:igt_e_pass_app/utils/extension.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:igt_e_pass_app/utils/validator.dart';
import 'package:provider/provider.dart';
import '../../../utils/general_utils.dart';
import '../profile/provider/profile_provider.dart';

class ChangPasswordPage extends StatelessWidget {
  const ChangPasswordPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => ProfileProvider(), child: const Body());
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;
  bool conPasswordVisible = true;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newConfirmPasswordController = TextEditingController();

  @override
  void initState() {
    if (Const.isDebug) {
      _currentPasswordController.text = 'Ab123456';
      _newPasswordController.text = 'Ab1234567';
      _newConfirmPasswordController.text = 'Ab1234567';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProfileProvider>(context);
    final enter = AppLocalizations.of(context)?.enter;
    final currentPassword = AppLocalizations.of(context)?.current_password;
    final newPassword = AppLocalizations.of(context)?.new_password;
    final confirmPassword = AppLocalizations.of(context)?.confirm_new_password;
    return MyScaffold(
        title: AppLocalizations.of(context)?.change_password,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(children: [
                      EntryField(
                          controller: _currentPasswordController,
                          label: currentPassword,
                          hint: "$enter $currentPassword",
                          image: 'assets/icons/id1.png',
                          maxLines: 1,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: oldPasswordVisible,
                          validator: (value) {
                            String t = value ?? '';
                            return t.trim().isNotEmpty
                                ? null
                                : AppLocalizations.of(context)!
                                    .current_pw_is_required;
                          },
                          suffixIcon: oldPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixIconAction: () => setState(
                              () => oldPasswordVisible = !oldPasswordVisible)),
                      const SizedBox(height: 10),
                      EntryField(
                          controller: _newPasswordController,
                          label: newPassword,
                          hint: "$enter $newPassword",
                          image: 'assets/icons/id1.png',
                          maxLines: 1,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: newPasswordVisible,
                          validator: (value) {
                            String t = value ?? '';
                            return t.trim().isNotEmpty
                                ? null
                                : AppLocalizations.of(context)!
                                    .new_pw_is_required;
                          },
                          suffixIcon: newPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixIconAction: () => setState(
                              () => newPasswordVisible = !newPasswordVisible)),
                      const SizedBox(height: 10),
                      EntryField(
                          controller: _newConfirmPasswordController,
                          label: confirmPassword,
                          hint: "$enter $confirmPassword",
                          image: 'assets/icons/id1.png',
                          maxLines: 1,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: conPasswordVisible,
                          validator: (value) =>
                              Validator.validateConfirmPassword(
                                  _newConfirmPasswordController.text, value),
                          suffixIcon: conPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixIconAction: () => setState(
                              () => conPasswordVisible = !conPasswordVisible))
                    ])))),
        bottomButton: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BuildCancelButton(),
                  BuildActiveButton(
                      title: AppLocalizations.of(context)!.update,
                      onTap: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          state
                              .doChangePassword(
                                  currentPassword:
                                      _currentPasswordController.text,
                                  newConfirmPassword:
                                      _newConfirmPasswordController.text,
                                  newPassword: _newPasswordController.text)
                              .whenComplete(() {
                            if (state.responeState.status == "success") {
                              GeneralUtil.showSnackBarMessage(
                                  isSuccess: true,
                                  context: context,
                                  message: state.responeState.message);
                              Nav.pop();
                            } else {
                              GeneralUtil.showSnackBarMessage(
                                  isSuccess: false,
                                  context: context,
                                  message: (state.responeState.message ?? '')
                                      .removeAllHtmlTags());
                            }
                          });
                        }
                      })
                ])));
  }
}
