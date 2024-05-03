import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/build_button.dart';
import 'package:igt_e_pass_app/components/dialog/show_visitor_card_id_type.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/data/model/pre_register/view_pre_register_model.dart';
import 'package:igt_e_pass_app/data/model/response_model.dart';
import 'package:igt_e_pass_app/data/model/selected_item_model.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/components/build_form_add_appointment.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/provider/department_provider.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/provider/pre_register_provider.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:igt_e_pass_app/utils/preference_helper.dart';
import 'package:provider/provider.dart';
import '../../../components/select_item_dialog.dart';
import '../../../resource/constant.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/extension.dart';
import '../choose_employee_page.dart';
import 'components/select_employee_page.dart';
import 'provider/employee_provider.dart';

class PreRegisterFormPage extends StatelessWidget {
  final AppointmentInfoModel? data;
  final List<SelectedItemModel>? selectedCard, notify;
  final bool reApp;

  const PreRegisterFormPage(
      {super.key,
      this.data,
      this.selectedCard,
      this.notify,
      this.reApp = false});

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PreRegisterProvider()),
            ChangeNotifierProvider(create: (_) => EmployeeProvider()),
            ChangeNotifierProvider(create: (_) => DepartmentProvider())
          ],
          child: Body(
              data: data,
              selectedCard: selectedCard,
              notify: notify,
              reApp: reApp));
}

class Body extends StatefulWidget {
  final AppointmentInfoModel? data;
  final List<SelectedItemModel>? selectedCard, notify;
  final bool reApp;

  const Body(
      {super.key,
      this.data,
      this.selectedCard,
      this.notify,
      required this.reApp});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cardIdController = TextEditingController();
  final expectDateController = TextEditingController();
  final expectTimeController = TextEditingController();
  final reasonController = TextEditingController();
  final departmentController = TextEditingController();
  final companyController = TextEditingController();
  final typeOfCardController = TextEditingController();
  final vehicleNoController = TextEditingController();
  final numberOfVisitorController = TextEditingController();
  final employeeController = TextEditingController();

  SelectedItemModel selectedEmployee = SelectedItemModel();
  List<SelectedItemModel> selectedNotifyTo = [];
  List<SelectedItemModel> selectedCardNumber = [];
  List<SelectedItemModel> departmentList = [];
  String departmentId = '';
  String empId = '';
  bool isTypeOfCardExp = false;
  bool isCardIdExp = false;

  @override
  void initState() {
    if (widget.data != null) setInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    departmentList = Provider.of<DepartmentProvider>(context).departmentList;
    return MyScaffold(
        title: AppLocalizations.of(context)?.book_appointment,
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: BuildFormAddAppointment(
                        nameController: nameController,
                        phoneController: phoneController,
                        cardIdController: cardIdController,
                        expectDateController: expectDateController,
                        expectTimeController: expectTimeController,
                        reasonController: reasonController,
                        departmentController: departmentController,
                        companyController: companyController,
                        typeOfCardController: typeOfCardController,
                        vehicleNoController: vehicleNoController,
                        numberOfVisitorController: numberOfVisitorController,
                        employeeController: employeeController,
                        onDepartmentTap: () => _showDepartmentSelect(),
                        onEmployeeTap: () => _showEmployeeSelect(context),
                        onNotifyTap: () => _showNotifyToSelect(context),
                        onCardTypeTap: () => showVisitorCardIdTypeDialog(
                            context,
                            (value) => setState(() =>
                                typeOfCardController.text = value.name ?? '')),
                        onChangeType: (value) =>
                            setState(() => isTypeOfCardExp = value),
                        onChangeCard: (value) =>
                            setState(() => isCardIdExp = value),
                        onChangeCardValue: (value) =>
                            setState(() => selectedCardNumber = value),
                        selectedNotifyTo: selectedNotifyTo,
                        selectedCardNumber: selectedCardNumber,
                        initTypeValue: isTypeOfCardExp,
                        initCardValue: isCardIdExp)))),
        bottomButton: Padding(
            padding: const EdgeInsets.all(20),
            child: BuildActiveButton(
                title: AppLocalizations.of(context)!.submit,
                onTap: _performUpdateOrCreate)));
  }

  Map<String, dynamic> _mapParam(bool isUpdate) {
    return {
      Const.visitorName: nameController.text,
      Const.numOfVisitor: numberOfVisitorController.text,
      Const.phone: phoneController.text,
      Const.companyName: companyController.text,
      Const.departmentId: departmentId,
      Const.empId: empId,
      Const.vehicleNumber: vehicleNoController.text,
      Const.expectedDate: expectDateController.text,
      Const.expectedTime: expectTimeController.text,
      Const.purpose: reasonController.text,
      Const.isTypeOfId: isTypeOfCardExp ? '1' : '0',
      Const.typeOfId: isTypeOfCardExp ? typeOfCardController.text : '',
      Const.typeOfIdNumber: isTypeOfCardExp ? cardIdController.text : '',
      Const.isVisitorCard: isCardIdExp ? '1' : '0',
      Const.cardId: isCardIdExp
          ? isUpdate
              ? jsonDecode(objToJson(selectedCardNumber))
              : objToJson(selectedCardNumber)
          : isUpdate
              ? jsonDecode("[]")
              : jsonEncode([]),
      Const.notifyTo: selectedNotifyTo.isNotEmpty
          ? isUpdate
              ? jsonDecode(objToJson(selectedNotifyTo))
              : objToJson(selectedNotifyTo)
          : isUpdate
              ? jsonDecode("[]")
              : jsonEncode([])
    };
  }

  void _performUpdateOrCreate() async {
    final state = Provider.of<PreRegisterProvider>(context, listen: false);
    if ((_formKey.currentState as FormState).validate()) {
      widget.reApp || widget.data?.id == null
          ? await state
              .addData(_mapParam(false))
              .whenComplete(() => _showSnackBar(state.responseStatus))
          : await state
              .updateData(jsonEncode(_mapParam(true)), widget.data?.id ?? '')
              .whenComplete(() => _showSnackBar(state.responseStatus));
    }
  }

  void _showSnackBar(ResponseModel response) {
    if (response.success == "true") {
      GeneralUtil.showSnackBarMessage(
              message: response.message, context: context, isSuccess: true)
          .then((value) => widget.reApp
              ? {Nav.pop(context: context), Nav.pop(context: context)}
              : Nav.pop(context: context));
    } else {
      GeneralUtil.showSnackBarMessage(
          message: response.message, context: context, isSuccess: false);
    }
  }

  void _showNotifyToSelect(BuildContext context) {
    final pleaseSelect = AppLocalizations.of(context)?.pls_select;
    final department =
        "${AppLocalizations.of(context)?.department} ${AppLocalizations.of(context)?.first}";
    if (departmentController.text.isNotEmpty) {
      Nav.push(ChooseNotifyToPage(departmentId: departmentId)).then((value) {
        selectedNotifyTo = value;
        setState(() {});
      });
    } else {
      GeneralUtil.showToast("$pleaseSelect ${department.toLowerCase()}");
    }
  }

  void _showEmployeeSelect(BuildContext context) {
    final pleaseSelect = AppLocalizations.of(context)?.pls_select;
    final department =
        "${AppLocalizations.of(context)?.department} ${AppLocalizations.of(context)?.first}";
    if (departmentController.text.isNotEmpty) {
      Nav.push(SelectEmployeePage(departmentId: departmentId)).then((value) {
        selectedEmployee = value;
        empId = selectedEmployee.id ?? '';
        employeeController.text = selectedEmployee.name ?? '';
        setState(() {});
      });
    } else {
      GeneralUtil.showToast("$pleaseSelect ${department.toLowerCase()}");
    }
  }

  void _showDepartmentSelect() async {
    final SelectedItemModel results = await showDialog(
        context: Nav.ctx,
        builder: (BuildContext context) => ItemsSelectDialog(
            items: departmentList,
            title:
                "${AppLocalizations.of(context)!.select} ${AppLocalizations.of(context)!.department}"));

    // Update UI
    setState(() {
      if (results.id != departmentId) {
        selectedNotifyTo.clear();
        selectedEmployee = SelectedItemModel();
        employeeController.clear();
        departmentController.text = results.name ?? '';
        departmentId = results.id ?? '';
      }
    });
  }

  void setInfo() {
    nameController.text = widget.data?.visitorName ?? '';
    numberOfVisitorController.text = widget.data?.visitorNumber ?? '';
    phoneController.text = widget.data?.phone ?? '';
    vehicleNoController.text = widget.data?.vehicleNumber ?? '';
    companyController.text = widget.data?.companyName ?? '';
    expectDateController.text =
        DateUtil.formatDate(widget.data?.expectedDate ?? '', true);
    expectTimeController.text = widget.data?.expectedTime ?? '';
    reasonController.text = widget.data?.purpose ?? '';

    ///default
    widget.data?.departmentId != null
        ? departmentId = widget.data?.departmentId ?? ''
        : departmentId = PrefsHelper.getString(Const.departmentId).toString();
    widget.data?.departmentName != null
        ? departmentController.text = widget.data?.departmentName ?? ''
        : departmentController.text =
            PrefsHelper.getString(Const.department).toString();

    widget.data?.empId != null
        ? empId = widget.data?.empId ?? ''
        : empId = PrefsHelper.getString(Const.empId).toString();
    widget.data?.empName != null
        ? employeeController.text = widget.data?.empName ?? ''
        : employeeController.text =
            PrefsHelper.getString(Const.employee).toString();

    ///
    isTypeOfCardExp = widget.data?.isTypeOfId == '1';
    isCardIdExp = widget.data?.isVisitorCard == '1';
    if (isTypeOfCardExp) {
      typeOfCardController.text = widget.data?.typeOfId ?? '';
      cardIdController.text = widget.data?.typeOfIdNumber ?? '';
    }
    if (isCardIdExp) {
      selectedCardNumber = widget.selectedCard ?? [];
    }
    if (widget.notify != null) {
      selectedNotifyTo = widget.notify ?? [];
    }
  }
}
