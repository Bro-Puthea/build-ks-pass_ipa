import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/build_button.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/data/model/selected_item_model.dart';
import 'package:igt_e_pass_app/data/model/visitor_param.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/provider/department_provider.dart';
import 'package:igt_e_pass_app/utils/extension.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:provider/provider.dart';
import '../../../components/select_item_dialog.dart';
import '../../../data/model/vistor/visitor_checkout_model.dart';
import '../../../styles/colors.dart';
import '../../../utils/validator.dart';
import '../../employee/choose_employee_page.dart';
import '../../employee/pre_register/components/select_employee_page.dart';
import 'visitor_register_page.dart';

class VisitorSelectEmployeePage extends StatelessWidget {
  final VisitorCheckoutModel? data;
  final bool autoAllow;

  const VisitorSelectEmployeePage(
      {super.key, this.data, this.autoAllow = false});

  @override
  Widget build(BuildContext context) => MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DepartmentProvider())],
      child: Body(data: data, autoAllow: autoAllow));
}

class Body extends StatefulWidget {
  final VisitorCheckoutModel? data;
  final bool autoAllow;

  const Body({super.key, this.data, required this.autoAllow});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _employeeController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  List<SelectedItemModel> departmentList = [];
  SelectedItemModel _selectedEmployee = SelectedItemModel();
  List<SelectedItemModel> _selectedNotifyTo = [];
  String departmentId = "";
  String employeeId = "";

  @override
  void initState() {
    setInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    departmentList = Provider.of<DepartmentProvider>(context).departmentList;
    final pleaseInput = AppLocalizations.of(context)?.pls_input;
    final enter = AppLocalizations.of(context)?.enter;
    final select = AppLocalizations.of(context)?.select;
    final employee = AppLocalizations.of(context)?.employee;
    final reason = AppLocalizations.of(context)?.reason;
    final department = AppLocalizations.of(context)?.department;
    final notifyTo = AppLocalizations.of(context)?.notify_to;
    final pleaseSelect = AppLocalizations.of(context)?.pls_select;

    return MyScaffold(
        title: employee,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(children: [
                      const SizedBox(height: 5),
                      EntryField(
                          controller: _departmentController,
                          label: "$department",
                          hint: "$select ${department?.toLowerCase()}",
                          readOnly: true,
                          onlySuffixIcon: Icons.arrow_drop_down,
                          validator: (v) {
                            String t = v ?? '';
                            return t.trim().isNotEmpty
                                ? null
                                : "$select ${department?.toLowerCase()}";
                          },
                          onTap: () => _showDepartmentSelect(context)),
                      const SizedBox(height: 5),
                      EntryField(
                          controller: _employeeController,
                          label: employee,
                          hint: "$select ${employee?.toLowerCase()}",
                          validator: (v) => kNullInputValidator(
                              v, "$pleaseSelect ${employee?.toLowerCase()}"),
                          readOnly: true,
                          onlySuffixIcon: Icons.arrow_drop_down,
                          onTap: () => _showEmployeeSelect(context)),
                      const SizedBox(height: 5),
                      InkWell(
                          onTap: () => _showNotifyToSelect(context),
                          child: Container(
                              child: _selectedNotifyTo.isEmpty
                                  ? EntryField(
                                      label: "$notifyTo",
                                      hint:
                                          "$select ${notifyTo?.toLowerCase()}",
                                      readOnly: true,
                                      onlySuffixIcon: Icons.arrow_drop_down,
                                      onTap: () => _showNotifyToSelect(context))
                                  : _buildContainerListData(
                                      _selectedNotifyTo))),
                      const SizedBox(height: 5),
                      EntryField(
                          keyboardType: TextInputType.multiline,
                          controller: _reasonController,
                          label: "$reason",
                          hint: "$enter ${reason?.toLowerCase()}",
                          maxLines: null,
                          minLines: 8)
                    ])))),
        bottomButton: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BuildCancelButton(),
                  BuildActiveButton(onTap: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      Nav.push(VisitorRegisterPage(
                          data: widget.data,
                          param: param(),
                          autoAllow: widget.autoAllow));
                    }
                  })
                ])));
  }

  void _showEmployeeSelect(BuildContext context) {
    final pleaseSelect = AppLocalizations.of(context)?.pls_select;
    final department =
        "${AppLocalizations.of(context)?.department} ${AppLocalizations.of(context)?.first}";
    if (_departmentController.text.isNotEmpty) {
      Nav.push(SelectEmployeePage(departmentId: departmentId)).then((value) {
        _selectedEmployee = value;
        _employeeController.text = _selectedEmployee.name ?? '';
        employeeId = _selectedEmployee.id ?? '';
        setState(() {});
      });
    } else {
      GeneralUtil.showToast("$pleaseSelect ${department.toLowerCase()}");
    }
  }

  void _showNotifyToSelect(BuildContext context) {
    final pleaseSelect = AppLocalizations.of(context)?.pls_select;
    final department =
        "${AppLocalizations.of(context)?.department} ${AppLocalizations.of(context)?.first}";
    if (_departmentController.text.isNotEmpty) {
      Nav.push(ChooseNotifyToPage(departmentId: departmentId)).then((value) {
        _selectedNotifyTo = value;
        setState(() {});
      });
    } else {
      GeneralUtil.showToast("$pleaseSelect ${department.toLowerCase()}");
    }
  }

  void _showDepartmentSelect(BuildContext context) async {
    final SelectedItemModel results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ItemsSelectDialog(
              items: departmentList,
              title:
                  "${AppLocalizations.of(context)?.select} ${AppLocalizations.of(context)?.select}");
        });
    // Update UI
    setState(() {
      if (results.id != departmentId) {
        _departmentController.text = results.name ?? '';
        departmentId = results.id ?? '';
        _selectedNotifyTo.clear();
        _employeeController.clear();
        _selectedEmployee = SelectedItemModel();
      }
    });
  }

  Widget _buildContainerListData(List<SelectedItemModel> dataList) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.0),
        width: MediaQuery.of(context).size.width,
        height: dataList.isEmpty ? 60 : null,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border:
                Border.all(width: 2, color: AppColors.textFieldUnFocusColor)),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Wrap(
                spacing: 5,
                children: dataList
                    .map((e) => Chip(
                        label: Text(e.name ?? ''),
                        deleteIcon:
                            const Icon(Icons.remove, color: Colors.black)))
                    .toList())));
  }

  void setInfo() {
    _departmentController.text = widget.data?.data?.departmentName ?? '';
    _employeeController.text = widget.data?.data?.empName ?? '';
    _reasonController.text = widget.data?.data?.purpose ?? '';

    _selectedNotifyTo = widget.data?.notify ?? [];
    departmentId = widget.data?.data?.departmentId ?? '';
    employeeId = widget.data?.data?.empId ?? '';
    setState(() {});
  }

  VisitorParam param() => VisitorParam(
      departmentId: departmentId,
      employeeId: employeeId,
      purpose: _reasonController.text,
      notifyTo: objToJson(_selectedNotifyTo),
      preRegisterId: widget.data?.data?.id ?? '');
}
