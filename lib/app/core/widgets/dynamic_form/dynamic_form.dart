import 'dart:developer';
import 'dart:io';

import '../../../data/constants/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../../data/constants/color_constant.dart';
import '../../../data/constants/constant.dart';
import '../../../data/constants/extensions/double_extension.dart';
import '../common_button.dart';
import '../common_image_picker_dialog.dart';
import '../common_textfield.dart';
import '../info_dialog.dart';
import '../text_field.dart';
import 'dynamic_form_model.dart' as model;

enum ComponentType {
  TEXT,
  TEXTAREA,
  SELECT,
  IC_NUMBER,
  INCREMENT,
  TIME,
  DATE,
  FILE,
  SEPARATOR,
  RADIO,
  CHECKBOX,
  BUTTON,
  PHONE,
  EMAIL,
  UNKNOWN
}

ComponentType getComponentType(String type) {
  switch (type) {
    case 'text':
      return ComponentType.TEXT;
    case 'textarea':
      return ComponentType.TEXTAREA;
    case 'select':
      return ComponentType.SELECT;
    case 'ic_number':
      return ComponentType.IC_NUMBER;
    case 'increment':
      return ComponentType.INCREMENT;
    case 'time':
      return ComponentType.TIME;
    case 'date':
      return ComponentType.DATE;
    case 'file':
      return ComponentType.FILE;
    case 'separator':
      return ComponentType.SEPARATOR;
    case 'radio':
      return ComponentType.RADIO;
    case 'checkbox':
      return ComponentType.CHECKBOX;
    case 'button':
      return ComponentType.BUTTON;
    case 'phone':
      return ComponentType.PHONE;
    case 'email':
      return ComponentType.EMAIL;

    default:
      return ComponentType.UNKNOWN;
  }
}

Widget getFormWidget(
    {required model.Datum item,
    required BuildContext context,
    required Rx<model.DynamicFormModel> formList}) {
  switch (item.componentType) {
    case ComponentType.UNKNOWN:
      return Text(
        item.label ?? '',
        style: context.textTheme.headline3!.copyWith(fontSize: 25),
      );
    case ComponentType.TEXT:
      return CommonFormTextField(item: item);

    case ComponentType.TEXTAREA:
      return CommonFormTextField(
        item: item,
        minLines: 5,
        maxLines: 10,
      );

    case ComponentType.INCREMENT:
      return CommonFormTextField(item: item);

    case ComponentType.TIME:
      return CommonFormTextField(
        item: item,
        enable: false,
      );

    case ComponentType.DATE:
      return CommonFormTextField(
        item: item,
        enable: false,
      );

    case ComponentType.PHONE:

    case ComponentType.IC_NUMBER:
      return CommonFormTextField(
        item: item,
        type: TextFieldType.PHONE,
      );

    case ComponentType.FILE:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: item.label ?? '',
                style: context.textTheme.headline6,
                children: <TextSpan>[
                  TextSpan(
                    text: ' *',
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.red),
                  )
                ]),
          ),
          (10.0).height,
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: Get.width * 0.05,
              runSpacing: 10,
              children:
                  List.generate((item.files?.length ?? 0) + 1, (indexImg) {
                if (indexImg == (item.files?.length ?? 0)) {
                  return (item.files?.length ?? 0) < 50
                      ? Container(
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.only(
                              right: Get.width * 0.02, top: Get.width * 0.02),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: ColorConstant.primaryColor,
                                  width: 0.8)),
                          child: const Icon(
                            Icons.add_link_rounded,
                            size: 40,
                          ),
                        ).onTap(
                          () => Get.dialog(
                            ImagePickerDialog(
                              cameraCallback: () {
                                dismissDialog();
                                // pickImageC(item);
                              },
                              galleryCallback: () {
                                dismissDialog();
                                // pickImage(item);
                              },
                              // fileCallback: () {
                              //   dismissDialog();
                              //   // pickFile(item);
                              // },
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                }

                return Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(
                          right: Get.width * 0.02, top: Get.width * 0.02),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(
                              color: ColorConstant.primaryColor, width: 0.8),
                          // image: DecorationImage(
                          //     image:
                          //         FileImage(item.files!.elementAt(indexImg)),
                          //     fit: BoxFit.fitWidth),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.file(
                          item.files!.elementAt(indexImg),
                          fit: BoxFit.fitWidth,
                          errorBuilder: (_, __, ___) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.file_present_rounded,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                (10.0).height,
                                Text(
                                  (item.files!.elementAt(indexImg) as File)
                                      .path
                                      .split('/')
                                      .last,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.headline6!
                                      .copyWith(fontSize: 12),
                                ).paddingSymmetric(horizontal: 10)
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: Get.width * 0.07,
                        height: Get.width * 0.07,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: const Icon(
                          LineIcons.trash,
                          color: Colors.white,
                        ),
                      ).onTap(
                        () => Get.dialog(
                          InfoDialog(
                            title: 'Padam Dokumen',
                            info:
                                "Adakah anda pasti untuk memadam dokumen ini?",
                            confirmText: "Padam",
                            confirmCallback: () {
                              item.files!.removeAt(indexImg);
                              formList.refresh();
                              dismissDialog();
                            },
                            cancelText: "Batal",
                            icon: const Center(
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          ).paddingOnly(left: Get.width * 0.06),
        ],
      ).marginOnly(bottom: 20);

    case ComponentType.RADIO:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: item.label ?? '',
                style: context.textTheme.headline6,
                children: <TextSpan>[
                  TextSpan(
                    text: item.required ?? false ? ' *' : '',
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.red),
                  )
                ]),
          ),
          (10.0).height,
          ListView.builder(
              itemCount: item.values?.length ?? 0,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (_, index) {
                var radioItem = item.values?.elementAt(index);
                return RadioListTile(
                    dense: true,
                    visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    activeColor: context.theme.primaryColor,
                    value: radioItem?.text ?? '',
                    title: Text(
                      radioItem?.text ?? '',
                      style: context.textTheme.headline6!
                          .copyWith(fontSize: 15, color: Colors.grey),
                    ),
                    groupValue: item.userData?.first,
                    onChanged: (_) {
                      item.userData?.clear();
                      item.userData?.add(_);
                      formList.refresh();
                    }).marginOnly(bottom: 10);
              })
        ],
      ).marginOnly(bottom: 30);

    case ComponentType.SELECT:
      return item.values!.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: item.label ?? '',
                      style: context.textTheme.headline6,
                      children: <TextSpan>[
                        TextSpan(
                          text: item.required ?? false ? ' *' : '',
                          style: context.textTheme.headline6!
                              .copyWith(color: Colors.red),
                        )
                      ]),
                ),
                (10.0).height,
                Container(
                  height:  50,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(
                        color: Colors.grey[300]!, width: 0.8),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: DropdownButton<model.Value>(
                    value: item.tempValue ??
                        getDropdownValue(item.values!, item.userData ?? []) ??
                        item.values?.first,
                    iconEnabledColor: ColorConstant.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                    isExpanded: true,
                    underline: Container(),
                    alignment: AlignmentDirectional.center,
                    items: item.values!.map((model.Value value) {
                      return DropdownMenuItem<model.Value>(
                        value: value,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: Get.width * 0.03),
                          child: Text(
                            value.text ?? '',
                            style: context.textTheme.headline6!,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (_) {
                      item.tempValue = _;
                      item.userData!.clear();
                      item.userData!.add(_?.id ?? '');
                      log("xxxx selected : ${item.userData?.first ?? ''}");
                      formList.refresh();
                    },
                  ),
                ),
              ],
            )
          : const SizedBox.shrink();

    case ComponentType.CHECKBOX:
      return Obx(() {
        return Row(
          children: [
            Checkbox(
                // title: Text(item.title ?? ''),
                //   contentPadding: EdgeInsets.zero,
                //   controlAffinity: ListTileControlAffinity.leading,
                value: item.checkBoxValue?.value,
                onChanged: (value) {
                  item.checkBoxValue!(value);
                }),
            Text(
              item.label ?? '',
              style: context.textTheme.headline6!.copyWith(),
            ),
          ],
        );
      });

    case ComponentType.BUTTON:
      return CommonButton(
          title: item.label ?? '',
          callBack: () {
            // getAllFormValue();
          });

    default:
      return const SizedBox.shrink();
  }
}

class CommonFormTextField extends StatelessWidget {
  final model.Datum item;
  final TextFieldType? type;
  final bool? enable;
  final int? minLines;
  final int? maxLines;
  final VoidCallback? onTap;

  const CommonFormTextField({
    Key? key,
    required this.item,
    this.type,
    this.enable,
    this.minLines,
    this.maxLines,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: item.label ?? '',
              style: context.textTheme.headline6,
              children: <TextSpan>[
                TextSpan(
                  text: item.required ?? false ? ' *' : '',
                  style:
                      context.textTheme.headline6!.copyWith(color: Colors.red),
                )
              ]),
        ),
        (10.0).height,
        SizedBox(
          height: 50,
          child: CommonTextField(
                  textEditingController:
                      item.textEditingController ?? TextEditingController(),
                  type: type,
                  minLines: minLines,
                  maxLines: maxLines,
                  enabled: enable,
                  hintText: item.label ?? '',
                  title: item.label ?? '')
              .onTap(onTap),
        ),
      ],
    ).marginOnly(bottom: 20);
  }
}

TextFieldType getTextFieldType({required String type}) {
  switch (type) {
    case 'password':
      return TextFieldType.PASSWORD;

    case 'confirmPassword':
      return TextFieldType.PASSWORD;

    case 'email':
      return TextFieldType.EMAIL;

    default:
      return TextFieldType.NAME;
  }
}

model.Value? getDropdownValue(
    List<model.Value> value, List<dynamic> valueIdSelected) {
  model.Value? finalValue;
  for (var item in value) {
    if (valueIdSelected.isNotEmpty) {
      if (item.id == valueIdSelected.first) {
        finalValue = item;
      }
    }
  }
  if (finalValue != null) {
    return finalValue;
  }

  return null;
}
