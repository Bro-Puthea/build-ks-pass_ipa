import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EntryField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? image;
  final String? initialValue;
  final Widget? labelWidget;
  final bool? readOnly;
  final bool? showCursor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final String? hint;
  final InputBorder? border;
  final IconData? suffixIcon;
  final IconData? onlySuffixIcon;
  final Function? onTap;
  final Function()? suffixIconAction;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final int? minLines;
  final Function? validator;
  final bool? enabled;
  final Function(String)? onChanged;

  const EntryField(
      {super.key,
      this.controller,
      this.label,
      this.image,
      this.labelWidget,
      this.initialValue,
      this.suffixIconAction,
      this.readOnly,
      this.keyboardType,
      this.textInputAction,
      this.maxLength,
      this.hint,
      this.border,
      this.maxLines,
      this.suffixIcon,
      this.onlySuffixIcon,
      this.onTap,
      this.minLines,
      this.textCapitalization,
      this.obscureText,
      this.validator,
      this.showCursor,
      this.enabled,
      this.onChanged});

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode1.addListener(() {
      setState(() {});
    });

    focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: TextFormField(
            focusNode: focusNode1,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.sentences,
            cursorColor: AppColors.primaryColorAccent,
            onTap: widget.onTap as void Function()?,
            onChanged: widget.onChanged,
            autofocus: false,
            enabled: widget.enabled,
            controller: widget.controller,
            validator: widget.validator as String? Function(String?)?,
            initialValue: widget.initialValue,
            readOnly: widget.readOnly ?? false,
            showCursor: widget.showCursor,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            style: MyText.body1(context)!.copyWith(
                color: focusNode1.hasFocus
                    ? Colors.white
                    : AppColors.textFieldUnFocusColor,
                fontWeight: FontWeight.bold),
            obscureText: widget.obscureText ?? false,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                //border: border,
                prefixIcon: (widget.image != null)
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        child: ImageIcon(AssetImage(widget.image!),
                            color: focusNode1.hasFocus
                                ? AppColors.primaryColorAccent
                                : AppColors.textFieldUnFocusColor,
                            size: 10.0))
                    : null,
                suffixIcon: widget.onlySuffixIcon != null
                    ? Icon(widget.onlySuffixIcon,
                        size: 18,
                        color: focusNode1.hasFocus
                            ? AppColors.primaryColorAccent
                            : AppColors.textFieldUnFocusColor)
                    : widget.suffixIconAction != null
                        ? IconButton(
                            onPressed: widget.suffixIconAction,
                            icon: Icon(widget.suffixIcon),
                            iconSize: 18,
                            color: focusNode1.hasFocus
                                ? AppColors.primaryColorAccent
                                : AppColors.textFieldUnFocusColor)
                        : null,
                labelText: widget.label,
                hintText: widget.hint,
                label: widget.labelWidget,
                hintStyle: MyText.caption(context)!.copyWith(
                    color: focusNode1.hasFocus
                        ? AppColors.primaryColorAccent
                        : AppColors.textFieldUnFocusColor),
                labelStyle: MyText.caption(context)!.copyWith(
                    color: focusNode1.hasFocus
                        ? AppColors.primaryColorAccent
                        : AppColors.textFieldUnFocusColor),
                //border: border,
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.primaryGreyText, width: 2)),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColorAccent, width: 3)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColorAccent, width: 2)),
                counter: const Offstage())));
  }
}

/// ================================================= SEARCH
class BuildSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final Function(String)? onSubmitted;

  const BuildSearchField(
      {Key? key, required this.controller, this.hint, this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onSubmitted: onSubmitted,
            style: MyText.body2(context)!.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.primaryGreyText,
                letterSpacing: 0.5),
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff1f1f1),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                hintText: hint ?? AppLocalizations.of(context)?.search,
                hintStyle: MyText.body1(context)!.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    decorationThickness: 6),
                prefixIcon: const Icon(Icons.search_rounded,
                    size: 20, color: Colors.grey))));
  }
}
