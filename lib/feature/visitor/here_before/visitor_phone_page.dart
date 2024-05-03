import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/feature/visitor/here_before/providers/been_here_before_provider.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../components/build_button.dart';
import '../../../utils/validator.dart';
import '../checkin/visitor_select_employee_page.dart';

class VisitorPhonePage extends StatelessWidget {
  const VisitorPhonePage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => BeenHereBeforProvider(), child: Body());
}

class Body extends StatelessWidget {
  Body({super.key});

  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<BeenHereBeforProvider>(context, listen: false);
    final phone = AppLocalizations.of(context)?.phone;
    final enter = AppLocalizations.of(context)?.enter;
    return MyScaffold(
        title: AppLocalizations.of(context)?.vistors,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(children: [
                      EntryField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          label: phone,
                          hint: "$enter ${phone?.toLowerCase()}",
                          validator: Validator.validatePhoneNumber),
                      const SizedBox(height: 5)
                    ])))),
        bottomButton: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BuildCancelButton(),
                  BuildActiveButton(onTap: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      state
                          .initData(phone: _phoneController.text)
                          .whenComplete(() {
                        if (state.beenHereBeforData.status == false) {
                          GeneralUtil.showSnackBarMessage(
                              isSuccess: false,
                              message: "Visitor was not found");
                        } else {
                          Nav.push(VisitorSelectEmployeePage(
                              data: state.beenHereBeforData));
                        }
                      });
                    }
                  })
                ])));
  }
}
