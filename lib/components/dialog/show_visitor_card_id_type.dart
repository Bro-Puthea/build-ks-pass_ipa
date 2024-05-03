import 'package:flutter/material.dart';
import '../../data/model/selected_item_model.dart';
import '../select_item_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showVisitorCardIdTypeDialog(
    BuildContext context, Function(SelectedItemModel) onTapChanged) async {
  final List<SelectedItemModel> items = [
    SelectedItemModel(id: '', name: "ID"),
    SelectedItemModel(id: '', name: "Driving"),
    SelectedItemModel(id: '', name: "Other"),
  ];

  final SelectedItemModel results = await showDialog(
      context: context,
      builder: (BuildContext context) => ItemsSelectDialog(
          title:
              "${AppLocalizations.of(context)!.select} ${AppLocalizations.of(context)!.vistor_card_id_type}",
          items: items));
  onTapChanged(results);
}
