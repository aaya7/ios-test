import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_image_placeholder.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/register_checklist_header_widget.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_bank_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_emergency_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_personal_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';

import '../../../../core/widgets/common_dropdown_widget.dart';
import '../../../../data/constants/color_constant.dart';

class ChecklistEmergencyInfoView
    extends GetView<ChecklistEmergencyInfoController> {
  const ChecklistEmergencyInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Emergency Contacts".tr),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.0.height,
              RegisterChecklistHeaderWidget(
                  icon: FontAwesomeIcons.truckMedical,
                  title: "Emergency Contacts".tr,
                  subtitle:
                  "For any emergency cases, we would need 2 personal contacts. This can be your next of kin or your family.".tr),
              30.0.height,
              ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: controller.emergencyContactInfoModel.value
                        .nextOfKinName !=
                        null
                        ? ColorConstant.primaryColor
                        : ColorConstant.textPrimaryColor,
                    collapseIcon: controller.emergencyContactInfoModel.value
                        .nextOfKinName !=
                        null
                        ? FontAwesomeIcons.check
                        : FontAwesomeIcons.minus,
                    expandIcon: controller.emergencyContactInfoModel.value
                        .nextOfKinName !=
                        null
                        ? FontAwesomeIcons.check
                        : FontAwesomeIcons.plus,
                    iconPadding: EdgeInsets.all(10),
                    iconSize: 15),
                header: Row(
                  children: [
                    Obx(() {
                      return controller.emergencyContactInfoModel.value
                          .checklistStatus ==
                          false
                          ? const Icon(
                        FontAwesomeIcons.warning,
                        color: Colors.red,
                        size: 15,
                      )
                          : const Icon(
                        FontAwesomeIcons.check,
                        color: ColorConstant.primaryColor,
                        size: 15,
                      );
                    }),
                    10.0.width,
                    Text(
                      "First Contact Details".tr,
                      style: context.textTheme.headline3!,
                    ),
                  ],
                ).paddingSymmetric(vertical: 10),
                collapsed: const SizedBox.shrink(),
                expanded: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.0.height,
                      Text("Contact Name".tr),
                      10.0.height,
                      CommonTextField(
                        hintText: "Contact Name".tr,
                        title: "Contact Name".tr,
                        textEditingController:
                        controller.firstContactNameTextController,
                        type: TextFieldType.NAME,
                      ),
                      20.0.height,
                      Text("Relationship".tr),
                      10.0.height,
                      // CommonTextField(
                      //   hintText: "Relationship",
                      //   title: "Relationship",
                      //   textEditingController:
                      //       controller.firstRelationshipTextController,
                      // ),
                      CommonDropdownWidget(selectedValue: controller
                          .selectedFirstRelationshipType,
                          dropdownList: controller.relationshipTypeList,
                          title: 'Relationship'.tr,
                          onChanged: (_) {
                            controller.selectedFirstRelationshipType.value = _;
                          },
                          displayItem: ''),
                      20.0.height,
                      Text("NRIC Number".tr),
                      10.0.height,
                      CommonTextField(
                        hintText: "NRIC Number".tr,
                        title: "NRIC Number".tr,
                        type: TextFieldType.IC,
                        textEditingController: controller.firstICTextController,
                      ),
                      20.0.height,
                      Text("Phone Number".tr),
                      10.0.height,
                      CommonTextField(
                        hintText: "Phone Number".tr,
                        title: "Phone Number".tr,
                        type: TextFieldType.PHONE,
                        textEditingController:
                        controller.firstPhoneTextController,
                      ),
                      // 20.0.height,
                      // const Text("Residential Address"),
                      // 10.0.height,
                      // CommonTextField(
                      //   hintText: "Apartment, suite, etc",
                      //   title: "Residential Address",
                      //   textEditingController:
                      //       controller.firstAddressTextController,
                      //   maxLines: 3,
                      //   minLines: 2,
                      // ),
                      // 20.0.height,
                      // Row(
                      //   children: [
                      //     Text(
                      //       "NRIC Front",
                      //       style: context.textTheme.headline3!
                      //           .copyWith(fontSize: 17),
                      //     ),
                      //     Text(
                      //       " (Required)",
                      //       style: context.textTheme.headline6!
                      //           .copyWith(color: Colors.orange, fontSize: 17),
                      //     ),
                      //   ],
                      // ),
                      // 5.0.height,
                      // const Text(
                      //     "Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well."),
                      // 20.0.height,
                      // SizedBox(
                      //   width: width,
                      //   child: Column(
                      //     children: [
                      //       Obx(() {
                      //         return CommonImagePlaceholder(
                      //           imageString: controller
                      //                   .emergencyContactInfoModel
                      //                   .value
                      //                   .nextOfKinNameFrontIcUrl ??
                      //               '',
                      //           imageFile: controller.firstFrontIC,
                      //           deleteCallback: (_) async {
                      //             if (controller.firstFrontIC.value != null) {
                      //               return true;
                      //             }
                      //
                      //             return await controller.deleteICPPhoto(
                      //                 isFirstContact: true, isFrontIC: true);
                      //           },
                      //         );
                      //       }),
                      //       10.0.height,
                      //       SizedBox(
                      //         width: width * 0.4,
                      //         child: CommonButton(
                      //           title: "Take Photo",
                      //           callBack: () {
                      //             CommonService.pickImageC(image: (_) {
                      //               controller.firstFrontIC.value = _;
                      //             });
                      //           },
                      //           border: Colors.grey[400],
                      //           buttonTextColor: ColorConstant.primaryColor,
                      //           buttonColor: Colors.white,
                      //           iconData: FontAwesomeIcons.camera,
                      //         ),
                      //       ),
                      //       10.0.height,
                      //       SizedBox(
                      //         width: width * 0.4,
                      //         child: CommonButton(
                      //           title: "Upload",
                      //           callBack: () {
                      //             CommonService.pickImage(image: (_) {
                      //               controller.firstFrontIC.value = _;
                      //             });
                      //           },
                      //           border: Colors.grey[400],
                      //           buttonTextColor: ColorConstant.primaryColor,
                      //           buttonColor: Colors.white,
                      //           iconData: FontAwesomeIcons.upload,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // 20.0.height,
                      // const Divider(
                      //   thickness: 0.5,
                      //   color: Colors.grey,
                      // ),
                      // 20.0.height,
                      // Row(
                      //   children: [
                      //     Text(
                      //       "NRIC Back",
                      //       style: context.textTheme.headline3!
                      //           .copyWith(fontSize: 17),
                      //     ),
                      //     Text(
                      //       " (Required)",
                      //       style: context.textTheme.headline6!
                      //           .copyWith(color: Colors.orange, fontSize: 17),
                      //     ),
                      //   ],
                      // ),
                      // 5.0.height,
                      // const Text(
                      //     "Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well."),
                      // 20.0.height,
                      // SizedBox(
                      //   width: width,
                      //   child: Column(
                      //     children: [
                      //       Obx(() {
                      //         return CommonImagePlaceholder(
                      //           imageString: controller
                      //                   .emergencyContactInfoModel
                      //                   .value
                      //                   .nextOfKinNameBackIcUrl ??
                      //               '',
                      //           imageFile: controller.firstBackIC,
                      //           deleteCallback: (_) async {
                      //             if (controller.firstBackIC.value != null) {
                      //               return true;
                      //             }
                      //
                      //             return await controller.deleteICPPhoto(
                      //                 isFirstContact: true, isFrontIC: false);
                      //           },
                      //         );
                      //       }),
                      //       10.0.height,
                      //       SizedBox(
                      //         width: width * 0.4,
                      //         child: CommonButton(
                      //           title: "Take Photo",
                      //           callBack: () {
                      //             CommonService.pickImageC(image: (_) {
                      //               controller.firstBackIC.value = _;
                      //             });
                      //           },
                      //           border: Colors.grey[400],
                      //           buttonTextColor: ColorConstant.primaryColor,
                      //           buttonColor: Colors.white,
                      //           iconData: FontAwesomeIcons.camera,
                      //         ),
                      //       ),
                      //       10.0.height,
                      //       SizedBox(
                      //         width: width * 0.4,
                      //         child: CommonButton(
                      //           title: "Upload",
                      //           callBack: () {
                      //             CommonService.pickImage(image: (_) {
                      //               controller.firstBackIC.value = _;
                      //             });
                      //           },
                      //           border: Colors.grey[400],
                      //           buttonTextColor: ColorConstant.primaryColor,
                      //           buttonColor: Colors.white,
                      //           iconData: FontAwesomeIcons.upload,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              5.0.height,
              Divider(
                thickness: 0.5,
                color: Colors.grey[300],
              ),
              10.0.height,
              Obx(() {
                return ExpandablePanel(
                  theme: ExpandableThemeData(
                      iconColor: controller.emergencyContactInfoModel.value
                          .secondaryNextOfKinName !=
                          null
                          ? ColorConstant.primaryColor
                          : ColorConstant.textPrimaryColor,
                      collapseIcon: controller.emergencyContactInfoModel.value
                          .secondaryNextOfKinName !=
                          null
                          ? FontAwesomeIcons.check
                          : FontAwesomeIcons.plus,
                      expandIcon: controller.emergencyContactInfoModel.value
                          .secondaryNextOfKinName !=
                          null
                          ? FontAwesomeIcons.check
                          : FontAwesomeIcons.plus,
                      iconPadding: EdgeInsets.all(10),
                      iconSize: 15),
                  header: Row(
                    children: [
                      25.0.width,
                      Text(
                        "Second Contact Details".tr,
                        style: context.textTheme.headline3!,
                      ),
                    ],
                  ).paddingSymmetric(vertical: 10),
                  collapsed: const SizedBox.shrink(),
                  expanded: Form(
                    key: controller.secondFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.0.height,
                        Text("Contact Name".tr),
                        10.0.height,
                        CommonTextField(
                          hintText: "Contact Name".tr,
                          title: "Contact Name".tr,
                          textEditingController:
                          controller.secondContactNameTextController,
                          type: TextFieldType.NAME,
                        ),
                        20.0.height,
                        Text("Relationship".tr),
                        10.0.height,
                        // CommonTextField(
                        //   hintText: "Relationship",
                        //   title: "Relationship",
                        //   textEditingController:
                        //   controller.secondRelationshipTextController,
                        // ),
                        CommonDropdownWidget(selectedValue: controller
                            .selectedSecondRelationshipType,
                            dropdownList: controller.relationshipTypeList,
                            title: 'Relationship'.tr,
                            onChanged: (_) {
                              controller.selectedSecondRelationshipType.value = _;
                            },
                            displayItem: ''),
                        20.0.height,
                        Text("NRIC Number".tr),
                        10.0.height,
                        CommonTextField(
                          hintText: "NRIC Number".tr,
                          title: "NRIC Number".tr,
                          type: TextFieldType.IC,
                          textEditingController:
                          controller.secondICTextController,
                        ),
                        20.0.height,
                        Text("Phone Number".tr),
                        10.0.height,
                        CommonTextField(
                          hintText: "Phone Number".tr,
                          title: "Phone Number".tr,
                          type: TextFieldType.PHONE,
                          textEditingController:
                          controller.secondPhoneTextController,
                        ),
                        // 20.0.height,
                        // const Text("Residential Address"),
                        // 10.0.height,
                        // CommonTextField(
                        //   hintText: "Apartment, suite, etc",
                        //   title: "Residential Address",
                        //   minLines: 2,
                        //   maxLines: 3,
                        //   textEditingController:
                        //       controller.secondAddressTextController,
                        // ),
                        // 20.0.height,
                        // Row(
                        //   children: [
                        //     Text(
                        //       "NRIC Front",
                        //       style: context.textTheme.headline3!
                        //           .copyWith(fontSize: 17),
                        //     ),
                        //     Text(
                        //       " (Required)",
                        //       style: context.textTheme.headline6!
                        //           .copyWith(color: Colors.orange, fontSize: 17),
                        //     ),
                        //   ],
                        // ),
                        // 5.0.height,
                        // const Text(
                        //     "Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well."),
                        // 20.0.height,
                        // SizedBox(
                        //   width: width,
                        //   child: Column(
                        //     children: [
                        //       Obx(() {
                        //         return CommonImagePlaceholder(
                        //           imageString: controller
                        //                   .emergencyContactInfoModel
                        //                   .value
                        //                   .secondaryNextOfKinFrontIcUrl ??
                        //               '',
                        //           imageFile: controller.secondFrontIC,
                        //           deleteCallback: (_) async {
                        //             if (controller.secondFrontIC.value != null) {
                        //               return true;
                        //             }
                        //
                        //             return await controller.deleteICPPhoto(
                        //                 isFirstContact: false, isFrontIC: true);
                        //           },
                        //         );
                        //       }),
                        //       10.0.height,
                        //       SizedBox(
                        //         width: width * 0.4,
                        //         child: CommonButton(
                        //           title: "Take Photo",
                        //           callBack: () {
                        //             CommonService.pickImageC(image: (_) {
                        //               controller.secondFrontIC.value = _;
                        //             });
                        //           },
                        //           border: Colors.grey[400],
                        //           buttonTextColor: ColorConstant.primaryColor,
                        //           buttonColor: Colors.white,
                        //           iconData: FontAwesomeIcons.camera,
                        //         ),
                        //       ),
                        //       10.0.height,
                        //       SizedBox(
                        //         width: width * 0.4,
                        //         child: CommonButton(
                        //           title: "Upload",
                        //           callBack: () {
                        //             CommonService.pickImage(image: (_) {
                        //               controller.secondFrontIC.value = _;
                        //             });
                        //           },
                        //           border: Colors.grey[400],
                        //           buttonTextColor: ColorConstant.primaryColor,
                        //           buttonColor: Colors.white,
                        //           iconData: FontAwesomeIcons.upload,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // 20.0.height,
                        // const Divider(
                        //   thickness: 0.5,
                        //   color: Colors.grey,
                        // ),
                        // 20.0.height,
                        // Row(
                        //   children: [
                        //     Text(
                        //       "NRIC Back",
                        //       style: context.textTheme.headline3!
                        //           .copyWith(fontSize: 17),
                        //     ),
                        //     Text(
                        //       "",
                        //       style: context.textTheme.headline6!
                        //           .copyWith(color: Colors.orange, fontSize: 17),
                        //     ),
                        //   ],
                        // ),
                        // 5.0.height,
                        // const Text(
                        //     "Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well."),
                        // 20.0.height,
                        // SizedBox(
                        //   width: width,
                        //   child: Column(
                        //     children: [
                        //       CommonImagePlaceholder(
                        //         imageString: controller
                        //                 .emergencyContactInfoModel
                        //                 .value
                        //                 .secondaryNextOfKinBackIcUrl ??
                        //             '',
                        //         imageFile: controller.secondBackIC,
                        //         deleteCallback: (_) async {
                        //           if (controller.secondBackIC.value != null) {
                        //             return true;
                        //           }
                        //
                        //           return await controller.deleteICPPhoto(
                        //               isFirstContact: false, isFrontIC: false);
                        //         },
                        //       ),
                        //       10.0.height,
                        //       SizedBox(
                        //         width: width * 0.4,
                        //         child: CommonButton(
                        //           title: "Take Photo",
                        //           callBack: () {
                        //             CommonService.pickImageC(image: (_) {
                        //               controller.secondBackIC.value = _;
                        //             });
                        //           },
                        //           border: Colors.grey[400],
                        //           buttonTextColor: ColorConstant.primaryColor,
                        //           buttonColor: Colors.white,
                        //           iconData: FontAwesomeIcons.camera,
                        //         ),
                        //       ),
                        //       10.0.height,
                        //       SizedBox(
                        //         width: width * 0.4,
                        //         child: CommonButton(
                        //           title: "Upload",
                        //           callBack: () {
                        //             CommonService.pickImage(image: (_) {
                        //               controller.secondBackIC.value = _;
                        //             });
                        //           },
                        //           border: Colors.grey[400],
                        //           buttonTextColor: ColorConstant.primaryColor,
                        //           buttonColor: Colors.white,
                        //           iconData: FontAwesomeIcons.upload,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              }),
              20.0.height,
              20.0.height,
            ],
          ).paddingSymmetric(horizontal: width * 0.04),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CommonButton(
            title: "Save".tr,
            callBack: () {
              controller.submitEmergencyContact();
            }),
      ),
    );
  }
}
