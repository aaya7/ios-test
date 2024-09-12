import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/widgets/text_field.dart';
import 'package:get/get.dart';

import '../../data/constants/color_constant.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final String title;
  final dynamic? prefixIconData;
  final TextFieldType? type;
  final bool? enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final bool? isValidationRequired;
  final bool? autovalid;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final FocusNode? node;
  final Color? borderColor;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmit;

  const CommonTextField({
    Key? key,
    this.textEditingController,
    required this.hintText,
    required this.title,
    this.prefixIconData,
    this.type,
    this.enabled,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.validator,
    this.isValidationRequired,
    this.autovalid,
    this.minLines,
    this.maxLines,
    this.textInputAction,
    this.node,
    this.borderColor,
    this.onChanged,
    this.onFieldSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
        textFieldType: type ?? TextFieldType.OTHER,
        controller: textEditingController,
        enabled: enabled ?? true,
        textInputAction: textInputAction,
        onChanged: onChanged,
        isValidationRequired: isValidationRequired,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmit,
        maxLength: maxLength,
        validator: validator,
        focus: node,
        title: title,
        minLines: minLines,
        textStyle: context.textTheme.headline6!.copyWith(
            color: (enabled ?? true)
                ? ColorConstant.textPrimaryColor
                : Colors.grey),
        maxLines: maxLines,
        autoValidate: autovalid ?? true,
        decoration: InputDecoration(
          filled: true,
          fillColor:
              (enabled ?? true) ? const Color(0xffFBFCFE) : Colors.grey[100]!,
          errorMaxLines: 5,
          isDense: true,
          counterText: "",
          // label: Text(
          //   title,
          //   style: context.textTheme.headline6!.apply(color: Colors.grey),
          // ),
          prefixIcon: prefixIconData != null
              ? prefixIconData is IconData
                  ? Icon(
                      prefixIconData,
                      color: const Color(0xff4F4F4F),
                    )
                  : prefixIconData as Widget
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.grey[400]!),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!, width: 0.8),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: borderColor ?? Colors.grey[400]!, width: 0.8),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!, width: 0.8),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          hintText: hintText,
        ));
  }
}
