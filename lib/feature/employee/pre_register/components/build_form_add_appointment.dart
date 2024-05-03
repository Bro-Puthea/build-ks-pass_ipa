import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/components/widget_chip_selection.dart';
import '../../../../components/entry_field.dart';
import '../../../../data/model/selected_item_model.dart';
import '../../../../styles/my_text.dart';
import '../../../../utils/date_utils.dart';
import '../../../../utils/general_utils.dart';
import '../../../../utils/validator.dart';

class BuildFormAddAppointment extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController cardIdController;
  final TextEditingController expectDateController;
  final TextEditingController expectTimeController;
  final TextEditingController reasonController;
  final TextEditingController departmentController;
  final TextEditingController companyController;
  final TextEditingController typeOfCardController;
  final TextEditingController vehicleNoController;
  final TextEditingController numberOfVisitorController;
  final TextEditingController employeeController;
  final Function() onDepartmentTap;
  final Function() onEmployeeTap;
  final Function() onNotifyTap;
  final Function() onCardTypeTap;
  final Function(bool value) onChangeType;
  final Function(bool value) onChangeCard;
  final Function(dynamic value) onChangeCardValue;
  final bool initTypeValue;
  final bool initCardValue;
  final List<SelectedItemModel> selectedNotifyTo;
  final List<SelectedItemModel> selectedCardNumber;

  const BuildFormAddAppointment(
      {Key? key,
      required this.nameController,
      required this.phoneController,
      required this.cardIdController,
      required this.expectDateController,
      required this.expectTimeController,
      required this.reasonController,
      required this.departmentController,
      required this.companyController,
      required this.typeOfCardController,
      required this.vehicleNoController,
      required this.numberOfVisitorController,
      required this.employeeController,
      required this.onDepartmentTap,
      required this.onEmployeeTap,
      required this.onNotifyTap,
      required this.onCardTypeTap,
      required this.onChangeType,
      required this.onChangeCard,
      this.initTypeValue = false,
      this.initCardValue = false,
      required this.selectedNotifyTo,
      required this.selectedCardNumber,
      required this.onChangeCardValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plsInput = AppLocalizations.of(context)?.pls_input;
    final enter = AppLocalizations.of(context)?.enter;
    final pleaseSelect = AppLocalizations.of(context)?.pls_select;
    final select = AppLocalizations.of(context)?.select;
    final vistorName = AppLocalizations.of(context)?.vistor_name;
    final numberOfVistors = AppLocalizations.of(context)?.numbers_of_vistor;
    final cardIdType = AppLocalizations.of(context)?.vistor_card_id_type;
    final id = AppLocalizations.of(context)?.id;
    final notifyTo = AppLocalizations.of(context)?.notify_to;
    final vehicleNo = AppLocalizations.of(context)?.vehicle_no;
    final vehicleNumber = AppLocalizations.of(context)?.vehicle_number;
    final phone = AppLocalizations.of(context)?.phone;
    final expectedDate = AppLocalizations.of(context)?.excepted_date;
    final expectedTime = AppLocalizations.of(context)?.excepted_time;
    final reason = AppLocalizations.of(context)?.reason;
    final department = AppLocalizations.of(context)?.department;
    final employee = AppLocalizations.of(context)?.employee;
    final company = AppLocalizations.of(context)?.company;
    final cardNo = AppLocalizations.of(context)?.card_no;
    final cardNumber = AppLocalizations.of(context)?.card_number;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
          alignment: Alignment.centerLeft,
          child: Text(AppLocalizations.of(context)!.personal_info,
              style: MyText.title(context))),
      const SizedBox(height: 5),
      EntryField(
          controller: nameController,
          label: vistorName,
          maxLines: 1,
          hint: "$enter ${vistorName?.toLowerCase()}",
          validator: (v) =>
              kNullInputValidator(v, "$plsInput ${vistorName?.toLowerCase()}")),
      const SizedBox(height: 5),
      Flex(direction: Axis.horizontal, children: [
        Flexible(
            child: EntryField(
                controller: numberOfVisitorController,
                label: numberOfVistors,
                maxLength: 3,
                maxLines: 1,
                keyboardType: TextInputType.number,
                hint: "$enter ${numberOfVistors?.toLowerCase()}",
                validator: (v) => kNullInputValidator(
                    v, "$plsInput ${numberOfVistors?.toLowerCase()}"))),
        const SizedBox(width: 15),
        Flexible(
            child: EntryField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                label: phone,
                maxLines: 1,
                hint: "$enter ${phone?.toLowerCase()}",
                validator: Validator.validatePhoneNumber))
      ]),
      const SizedBox(height: 5),
      Flex(direction: Axis.horizontal, children: [
        Flexible(
            child: EntryField(
                controller: expectDateController,
                label: expectedDate,
                readOnly: true,
                showCursor: false,
                hint: "$select ${expectedDate?.toLowerCase()}",
                validator: (v) => kNullInputValidator(
                    v, "$pleaseSelect ${expectedDate?.toLowerCase()}"),
                onTap: () =>
                    GeneralUtil.showDatesPicker(context: context).then((value) {
                      expectDateController.text =
                          DateUtil.formatDate(value.toString(), true);
                    }))),
        const SizedBox(width: 15),
        Flexible(
            child: EntryField(
                controller: expectTimeController,
                label: expectedTime,
                readOnly: true,
                showCursor: false,
                hint: "$enter ${expectedTime?.toLowerCase()}",
                validator: (v) => kNullInputValidator(
                    v, "$pleaseSelect ${expectedTime?.toLowerCase()}"),
                onTap: () =>
                    GeneralUtil.showTimesPicker(context: context).then((value) {
                      expectTimeController.text = value ?? '';
                    }))),
      ]),
      const SizedBox(height: 5),
      EntryField(
          keyboardType: TextInputType.text,
          controller: companyController,
          label: company,
          hint: "$enter ${company?.toLowerCase()}",
          validator: (v) =>
              kNullInputValidator(v, "$plsInput ${company?.toLowerCase()}")),
      const SizedBox(height: 5),
      EntryField(
          keyboardType: TextInputType.text,
          controller: vehicleNoController,
          label: vehicleNo,
          hint: "$enter ${vehicleNumber?.toLowerCase()}"),
      const SizedBox(height: 5),
      EntryField(
          controller: departmentController,
          label: department,
          hint: "$select ${department?.toLowerCase()}",
          validator: (v) => kNullInputValidator(
              v, "$pleaseSelect ${department?.toLowerCase()}"),
          readOnly: true,
          showCursor: false,
          onlySuffixIcon: Icons.arrow_drop_down,
          onTap: onDepartmentTap),
      const SizedBox(height: 5),
      EntryField(
          controller: employeeController,
          label: employee,
          hint: "$select ${employee?.toLowerCase()}",
          validator: (v) => kNullInputValidator(
              v, "$pleaseSelect ${employee?.toLowerCase()}"),
          readOnly: true,
          showCursor: false,
          onlySuffixIcon: Icons.arrow_drop_down,
          onTap: onEmployeeTap),
      const SizedBox(height: 5),
      EntryField(
          keyboardType: TextInputType.multiline,
          controller: reasonController,
          label: reason,
          hint: "$enter ${reason?.toLowerCase()}",
          maxLines: null,
          minLines: 8),
      const SizedBox(height: 10),
      InkWell(
          onTap: onNotifyTap,
          child: selectedNotifyTo.isEmpty
              ? EntryField(
                  label: "$notifyTo",
                  hint: "$select ${notifyTo?.toLowerCase()}",
                  readOnly: true,
                  showCursor: false,
                  onlySuffixIcon: Icons.arrow_drop_down,
                  onTap: onNotifyTap)
              : WidgetChipSelection(data: selectedNotifyTo)),

/*      const SizedBox(height: 5),
      MyExpansionTile(
          title: cardIdType,
          initiallyExpanded: initTypeValue,
          onChecked: onChangeType, //isTypeOfCardExp = value,
          childrenWidget: [
            const SizedBox(height: 5),
            EntryField(
                controller: typeOfCardController,
                label: cardIdType,
                readOnly: true,
                showCursor: false,
                hint: "$select ${cardIdType?.toLowerCase()}",
                onTap: onCardTypeTap),
            EntryField(
                keyboardType: TextInputType.text,
                controller: cardIdController,
                label: id,
                hint: "$enter ${id?.toLowerCase()}",
                validator: (v) =>
                    kNullInputValidator(v, "$plsInput ${id?.toLowerCase()}"))
          ]),
      const SizedBox(height: 5),
      MyExpansionTile(
          title: cardNo,
          initiallyExpanded: initCardValue,
          onChecked: onChangeCard,
          childrenWidget: [
            const SizedBox(height: 5),
            InkWell(
                onTap: () =>
                    Nav.push(const ChooseVisitorCardNumberPage())
                        .then((value) => onChangeCardValue(value)),
                child: selectedCardNumber.isEmpty
                    ? EntryField(
                        label: "$cardNo",
                        hint: "$select ${cardNumber?.toLowerCase()}",
                        readOnly: true,
                        showCursor: false,
                        suffixIcon: Icons.arrow_drop_down,
                        onTap: () =>
                            Nav.push(const ChooseVisitorCardNumberPage())
                                .then((value) => onChangeCardValue(value)))
                    : WidgetChipSelection(data: selectedCardNumber))
          ])*/
    ]);
  }
}
