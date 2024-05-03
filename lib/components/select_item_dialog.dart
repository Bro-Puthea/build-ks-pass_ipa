import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import '../data/model/selected_item_model.dart';
import '../styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemsSelectDialog extends StatefulWidget {
  final String title;
  final List<SelectedItemModel> items;
  const ItemsSelectDialog({Key? key, required this.items,required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemsSelectDialogState();
}

class _ItemsSelectDialogState extends State<ItemsSelectDialog> {

  void _itemChange(SelectedItemModel itemValue) {
    setState(() {
      Navigator.pop(context, itemValue);
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title, style: MyText.subtitle(context)),
      titleTextStyle: MyText.title(context),
      contentTextStyle: MyText.subhead(context),
      backgroundColor: AppColors.primaryBackground,
      content: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: 300,
          child: ListBody(
            children: widget.items
                .map((item) => ListTile(
                      onTap: () => _itemChange(item),
                      title: Text(
                        item.name ?? '',
                        style: MyText.subtitle(context)
                            ?.copyWith(color: Colors.white),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: _cancel,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(
                  width: 2.0,
                  color: Colors.red,
                )),
            child: Text('${AppLocalizations.of(context)?.cancel}',
                style: MyText.button(context)?.copyWith(color: Colors.red)),
          ),
        )
      ],
    );
  }
}
