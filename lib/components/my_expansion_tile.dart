import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/my_text.dart';

class MyExpansionTile extends StatefulWidget {
  final String? title;
  final List<Widget>? childrenWidget;
  final bool? initiallyExpanded;
  final Function(bool value)? onChecked;

  const MyExpansionTile(
      {super.key,
      this.title,
      this.childrenWidget,
      this.initiallyExpanded,
      this.onChecked});

  @override
  State<MyExpansionTile> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = widget.initiallyExpanded ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Theme(
        data: ThemeData().copyWith(
            unselectedWidgetColor:
                AppColors.textFieldUnFocusColor, // here for close state
            dividerColor: Colors.transparent),
        child: ExpansionTile(
            key: formKey,
            initiallyExpanded: isExpanded,
            trailing: SizedBox(),
            tilePadding: EdgeInsets.zero,
            title: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {});
                  isExpanded = !isExpanded;
                  widget.onChecked!(isExpanded);
                },
                value: isExpanded,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(widget.title ?? '', style: MyText.body1(context))),
            children: widget.childrenWidget ?? []));
  }
}
