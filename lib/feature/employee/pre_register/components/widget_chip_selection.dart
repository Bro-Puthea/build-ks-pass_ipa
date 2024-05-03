import 'package:flutter/material.dart';
import '../../../../data/model/selected_item_model.dart';
import '../../../../styles/colors.dart';

class WidgetChipSelection extends StatelessWidget {
  final List<SelectedItemModel> data;

  const WidgetChipSelection({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.0),
      width: MediaQuery.of(context).size.width,
      height: data.isEmpty ? 60 : null,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(width: 2, color: AppColors.textFieldUnFocusColor)),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Wrap(
              spacing: 5,
              children: data
                  .map((e) => Chip(
                      label: Text(e.name ?? ''),
                      deleteIcon:
                          const Icon(Icons.remove, color: Colors.black)))
                  .toList())));
}
