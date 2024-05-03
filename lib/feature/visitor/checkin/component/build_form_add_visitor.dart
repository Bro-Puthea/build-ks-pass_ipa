import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/data/model/selected_item_model.dart';
import '../../../../components/dialog/show_visitor_card_id_type.dart';
import '../../../../components/entry_field.dart';
import '../../../../components/my_expansion_tile.dart';
import '../../../../styles/colors.dart';
import '../../../../utils/general_utils.dart';
import '../../../../utils/my_navigator.dart';
import '../../../../utils/validator.dart';
import '../../../employee/choose_vistor_card_number.dart';

class BuildFormAddVisitor extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController visitorNumberController;
  final TextEditingController phoneController;
  final TextEditingController companyController;
  final TextEditingController vehicleController;
  final TextEditingController typeOfCardController;
  final TextEditingController cardIdController;
  final bool initIsTypeOfId, initIsCardNo;
  final Function(bool) onTypeOfIdChanged, onCardNoChanged;
  final Function(SelectedItemModel) onReceiveTypeIdChanged;
  final Function(List<SelectedItemModel>) onReceiveCardNoChanged;
  final List<SelectedItemModel> selectedCardNo;
  final Function(String) onNumberOfVisitorChanged;

  const BuildFormAddVisitor(
      {Key? key,
      required this.nameController,
      required this.visitorNumberController,
      required this.phoneController,
      required this.companyController,
      required this.vehicleController,
      required this.typeOfCardController,
      required this.cardIdController,
      required this.initIsTypeOfId,
      required this.initIsCardNo,
      required this.onTypeOfIdChanged,
      required this.onCardNoChanged,
      required this.onReceiveTypeIdChanged,
      required this.onReceiveCardNoChanged,
      required this.selectedCardNo,
      required this.onNumberOfVisitorChanged})
      : super(key: key);

  @override
  State<BuildFormAddVisitor> createState() => _BuildFormAddVisitorState();
}

class _BuildFormAddVisitorState extends State<BuildFormAddVisitor> {
  @override
  Widget build(BuildContext context) {
    final plsInput = AppLocalizations.of(context)?.pls_input;
    final select = AppLocalizations.of(context)?.select;
    final enter = AppLocalizations.of(context)?.enter;
    final name = AppLocalizations.of(context)?.name;
    final numberOfVistors = AppLocalizations.of(context)?.numbers_of_vistor;
    final cardIdType = AppLocalizations.of(context)?.vistor_card_id_type;
    final id = AppLocalizations.of(context)?.id;
    final vehicleNo = AppLocalizations.of(context)?.vehicle_no;
    final vehicleNumber = AppLocalizations.of(context)?.vehicle_number;
    final phone = AppLocalizations.of(context)?.phone;
    final company = AppLocalizations.of(context)?.company;
    final cardNo = AppLocalizations.of(context)?.card_no;
    final cardNumber = AppLocalizations.of(context)?.card_number;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      EntryField(
          controller: widget.nameController,
          label: name,
          hint: "$enter ${name?.toLowerCase()}",
          validator: (v) =>
              kNullInputValidator(v, "$plsInput ${name?.toLowerCase()}")),
      const SizedBox(height: 5),
      Flex(direction: Axis.horizontal, children: [
        Flexible(
            child: EntryField(
                controller: widget.visitorNumberController,
                label: numberOfVistors,
                maxLength: 3,
                keyboardType: TextInputType.number,
                hint: "$enter ${numberOfVistors?.toLowerCase()}",
                validator: (v) => kNullInputValidator(
                    v, "$plsInput ${numberOfVistors?.toLowerCase()}"),
                onChanged: widget.onNumberOfVisitorChanged)),
        const SizedBox(width: 15),
        Flexible(
            child: EntryField(
                controller: widget.phoneController,
                keyboardType: TextInputType.phone,
                label: phone,
                hint: "$enter ${phone?.toLowerCase()}",
                validator: Validator.validatePhoneNumber))
      ]),
      const SizedBox(height: 5),
      EntryField(
          keyboardType: TextInputType.text,
          controller: widget.vehicleController,
          label: vehicleNo,
          hint: "$enter ${vehicleNumber?.toLowerCase()}"),
      const SizedBox(height: 5),
      EntryField(
          controller: widget.companyController,
          label: company,
          hint: "$enter ${company?.toLowerCase()}",
          validator: (v) =>
              kNullInputValidator(v, "$plsInput ${company?.toLowerCase()}")),
      const SizedBox(height: 5),
      MyExpansionTile(
          title: cardIdType,
          initiallyExpanded: widget.initIsTypeOfId,
          onChecked: widget.onTypeOfIdChanged,
          childrenWidget: [
            const SizedBox(height: 5),
            EntryField(
                controller: widget.typeOfCardController,
                label: cardIdType,
                readOnly: true,
                showCursor: false,
                hint: "$select ${cardIdType?.toLowerCase()}",
                validator: (v) => kNullInputValidator(
                    v, "$select ${cardIdType?.toLowerCase()}"),
                onTap: () => showVisitorCardIdTypeDialog(
                    context, widget.onReceiveTypeIdChanged)),
            EntryField(
                keyboardType: TextInputType.text,
                controller: widget.cardIdController,
                label: id,
                hint: "$enter ${id?.toLowerCase()}",
                validator: (v) =>
                    kNullInputValidator(v, "$plsInput ${id?.toLowerCase()}"))
          ]),
      const SizedBox(height: 5),
      MyExpansionTile(
          title: cardNo,
          initiallyExpanded: widget.initIsCardNo,
          onChecked: widget.onCardNoChanged,
          childrenWidget: [
            const SizedBox(height: 5),
            InkWell(
                onTap: () => _onChooseCard(
                    '$plsInput ${numberOfVistors?.toLowerCase()}'),
                child: Container(
                    child: widget.selectedCardNo.isEmpty
                        ? EntryField(
                            label: "$cardNo",
                            hint: "$select ${cardNumber?.toLowerCase()}",
                            readOnly: true,
                            suffixIcon: Icons.arrow_drop_down,
                            validator: (v) => kNullInputValidator(
                                v, "$select ${cardNumber?.toLowerCase()}"),
                            onTap: () => _onChooseCard(
                                '$plsInput ${numberOfVistors?.toLowerCase()}'))
                        : _buildContainerListData(context)))
          ])
    ]);
  }

  _onChooseCard(String msg) =>
      widget.visitorNumberController.text.trim().isNotEmpty &&
              int.parse(widget.visitorNumberController.text.trim()) > 0
          ? Nav.push(ChooseVisitorCardNumberPage(
                  count: int.parse(widget.visitorNumberController.text.trim())))
              .then((value) => widget.onReceiveCardNoChanged(value))
          : GeneralUtil.showToast(msg);

  Widget _buildContainerListData(BuildContext context) => Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.0),
      width: MediaQuery.of(context).size.width,
      height: widget.selectedCardNo.isEmpty ? 60 : null,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(width: 2, color: AppColors.textFieldUnFocusColor)),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Wrap(
              spacing: 5,
              children: widget.selectedCardNo
                  .map((e) => Chip(
                      label: Text(e.name ?? ''),
                      deleteIcon:
                          const Icon(Icons.remove, color: Colors.black)))
                  .toList())));
}
