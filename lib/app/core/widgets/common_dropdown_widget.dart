import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../data/constants/color_constant.dart';

class CommonDropdownWidget extends StatelessWidget {
  const CommonDropdownWidget({
    super.key,
    required this.selectedValue,
    required this.dropdownList,
    required this.title,
    this.isEnabled,
    required this.onChanged,
    this.borderColor,
    required this.displayItem,
    this.hintText,
  });

  final Rxn<dynamic> selectedValue;
  final RxList<dynamic> dropdownList;
  final String title;
  final String? hintText;
  final bool? isEnabled;
  final String displayItem;
  final void Function(dynamic) onChanged;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Obx(() {
        return DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<dynamic>(
            value: selectedValue.value,
            // iconEnabledColor: context.theme.primaryColor,
            // borderRadius: BorderRadius.circular(10),
            iconStyleData: const IconStyleData(
                icon: Icon(FontAwesomeIcons.chevronDown),
                iconSize: 14,
                iconEnabledColor: ColorConstant.primaryColor),
            alignment: Alignment.center,
            isExpanded: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              filled: true,
              // contentPadding: EdgeInsets.all(12),
              fillColor: const Color(0xffFBFCFE),
              errorMaxLines: 3,
              isDense: true,
              hintStyle:
                  context.textTheme.headline6!.copyWith(color: Colors.grey),
              counterText: "",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? Colors.grey[400]!),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!, width: 0.8),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? Colors.grey[400]!, width: 0.8),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!, width: 0.8),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              hintText: hintText ?? "${'Please select'.tr} $title",
            ),
            //
            items: dropdownList.map((dynamic value) {
              try {
                var decodedJson = jsonDecode(jsonEncode(value));
                return DropdownMenuItem<dynamic>(
                  value: value,
                  child: Text(
                    decodedJson[displayItem].toString(),
                    style: context.textTheme.headline6!,
                  ),
                );
              } catch (error, st) {}
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(
                  value.toString(),
                  style: context.textTheme.headline6!,
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
                return "${'Please select'.tr} $title";
              }
              return null;
            },
            onChanged: onChanged,
          ),
        );
      }),
    );
  }
}

class CommonMultiDropdownWidget extends StatelessWidget {
  const CommonMultiDropdownWidget({
    super.key,
    required this.selectedValue,
    required this.dropdownList,
    required this.title,
    this.isEnabled,
    required this.onChanged,
    this.borderColor,
    required this.displayItem,
    this.hintText,
  });

  final RxList<dynamic> selectedValue;
  final RxList<dynamic> dropdownList;
  final String title;
  final String? hintText;
  final bool? isEnabled;
  final String displayItem;
  final void Function(List<dynamic>) onChanged;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final selected = <String>[].obs;
    return Obx(() {
      return DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<dynamic>(
          value: selectedValue.isEmpty ? null : selectedValue.last,
          // iconEnabledColor: context.theme.primaryColor,
          // borderRadius: BorderRadius.circular(10),
          isExpanded: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.all(12),
            fillColor: Color(0xffFBFCFE),
            errorMaxLines: 3,
            hintStyle:
                context.textTheme.headline6!.copyWith(color: Colors.grey),
            counterText: "",
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.grey[400]!),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!, width: 0.8),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: borderColor ?? Colors.grey[400]!, width: 0.8),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!, width: 0.8),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            hintText: hintText ?? "${'Please select'.tr} $title",
          ),
          //
          items: dropdownList.map((dynamic value) {
            try {
              var decodedJson = jsonDecode(jsonEncode(value));
              // decodedJson[displayItem].toString(),

              return DropdownMenuItem<dynamic>(
                value: value,
                enabled: false,
                child: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    final isSelected = selectedValue.contains(value);
                    return Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: null,
                            fillColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                return ColorConstant.primaryColor;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              decodedJson[displayItem].toString(),
                              style: context.textTheme.headline6!,
                            ),
                          ),
                        ],
                      ),
                    ).onTap(() {
                      isSelected
                          ? selectedValue.remove(value)
                          : selectedValue.add(value);
                      setState(() {});
                    });
                  },
                ),
              );
            } catch (error, st) {
              log("xxx decode dropdown $error");
            }

            return DropdownMenuItem<dynamic>(
              value: value,
              enabled: false,
              child: StatefulBuilder(
                  builder: (context, void Function(void Function()) setState) {
                final isSelected = selectedValue.contains(value);
                return Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      if (isSelected)
                        const Icon(Icons.check_box_outlined)
                      else
                        const Icon(Icons.check_box_outline_blank),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          value.toString(),
                          style: context.textTheme.headline6!,
                        ),
                      ),
                    ],
                  ),
                ).onTap(() {
                  isSelected
                      ? selectedValue.remove(value)
                      : selectedValue.add(value);
                  setState(() {});
                  //This rebuilds the dropdownMenu Widget to update the check mark
                });
              }),
            );
          }).toList(),
          selectedItemBuilder: (context) {
            return selectedValue
                .map((element) => Text(element.toString()))
                .toList();
            // return selectedValue.map(
            //       (item) {
            //     try {
            //       var decode = jsonDecode(jsonEncode(item));
            //       selected.add(decode[displayItem]);
            //     } catch (error, st) {
            //       log("xxx $error $st");
            //       selected.add(item);
            //     }
            //
            //     return Obx(() {
            //       return Container(
            //         alignment: AlignmentDirectional.center,
            //         child: Text(
            //           getSpannedText(selected),
            //           style: context.textTheme.headline6!,
            //           maxLines: 1,
            //         ),
            //       );
            //     });
            //   },
            // ).toList();
          },
          validator: (value) {
            if (value.isEmpty) {
              return "${'Please select'.tr} $title";
            }
            return null;
          },
          onChanged: (_) {},
        ),
      );
    });
  }
}

String getSpannedText(List<String> strings) {
  var text = "";

  if (strings.length == 1) {
    return strings.first;
  }

  for (var item in strings) {
    text = "$item, $text";
  }

  return text;
}
