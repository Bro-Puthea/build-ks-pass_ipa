import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/component/build_form_add_visitor.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/take_photo_page.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import '../../../components/build_button.dart';
import '../../../data/model/selected_item_model.dart';
import '../../../data/model/visitor_param.dart';
import '../../../data/model/vistor/visitor_checkout_model.dart';
import '../../../utils/extension.dart';

class VisitorRegisterPage extends StatefulWidget {
  final VisitorCheckoutModel? data;
  final VisitorParam param;
  final bool autoAllow;

  const VisitorRegisterPage(
      {super.key, this.data, required this.param, required this.autoAllow});

  @override
  State<VisitorRegisterPage> createState() => _VisitorRegisterPageState();
}

class _VisitorRegisterPageState extends State<VisitorRegisterPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController visitorNumberController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController typeOfCardController = TextEditingController();
  final TextEditingController cardIdController = TextEditingController();
  List<SelectedItemModel> _selectedCardNumber = [];
  bool isCardNumExpand = false;
  bool isTypeOfCardExp = false;

  @override
  void initState() {
    if (widget.data != null) setInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        title: AppLocalizations.of(context)?.vistor_detail,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: BuildFormAddVisitor(
                        nameController: nameController,
                        visitorNumberController: visitorNumberController,
                        phoneController: phoneController,
                        companyController: companyController,
                        vehicleController: vehicleController,
                        typeOfCardController: typeOfCardController,
                        cardIdController: cardIdController,
                        onNumberOfVisitorChanged: (value) {
                          _selectedCardNumber.clear();
                          setState(() {});
                        },
                        initIsTypeOfId: isTypeOfCardExp,
                        initIsCardNo: isCardNumExpand,
                        onTypeOfIdChanged: (value) =>
                            setState(() => isTypeOfCardExp = value),
                        onCardNoChanged: (value) =>
                            setState(() => isCardNumExpand = value),
                        onReceiveTypeIdChanged: (value) => setState(
                            () => typeOfCardController.text = value.name ?? ''),
                        onReceiveCardNoChanged: (value) =>
                            setState(() => _selectedCardNumber = value),
                        selectedCardNo: _selectedCardNumber)))),
        bottomButton: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BuildCancelButton(),
                  BuildActiveButton(onTap: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      Nav.push(TakePhotoPage(
                          param: param(), autoAllow: widget.autoAllow));
                    }
                  })
                ])));
  }

  VisitorParam param() => VisitorParam(
      departmentId: widget.param.departmentId,
      employeeId: widget.param.employeeId,
      purpose: widget.param.purpose,
      visitorName: nameController.text,
      visitorNumber: visitorNumberController.text,
      phone: phoneController.text,
      vehicleNumber: vehicleController.text,
      companyName: companyController.text,
      isTypeOfId: isTypeOfCardExp ? '1' : '0',
      typeOfId: typeOfCardController.text,
      typeOfIdNumber: cardIdController.text,
      isVisitorCard: isCardNumExpand ? '1' : '0',
      cardId: objToJson(_selectedCardNumber),
      notifyTo: widget.param.notifyTo,
      preRegisterId: widget.param.preRegisterId);

  void setInfo() {
    nameController.text = widget.data?.data?.visitorName ?? '';
    visitorNumberController.text = widget.data?.data?.visitorNumber ?? '';
    phoneController.text = widget.data?.data?.phone ?? '';
    vehicleController.text = widget.data?.data?.vehicleNumber ?? '';
    companyController.text = widget.data?.data?.companyName ?? '';

    isTypeOfCardExp = widget.data?.data?.isTypeOfId == '1';
    isCardNumExpand = widget.data?.data?.isVisitorCard == '1';
    if (isTypeOfCardExp) {
      typeOfCardController.text = widget.data?.data?.typeOfId ?? '';
      cardIdController.text = widget.data?.data?.typeOfIdNumber ?? '';
    }
    if (isCardNumExpand) _selectedCardNumber = widget.data?.cardId ?? [];

    setState(() {});
  }
}
