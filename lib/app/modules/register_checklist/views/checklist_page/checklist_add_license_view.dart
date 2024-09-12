import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/register_checklist_header_widget.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_license_info_model.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_license_info_controller.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../core/services/common_services.dart';
import '../../../../core/widgets/common_dropdown_widget.dart';
import '../../../../core/widgets/common_image_placeholder.dart';
import '../../../../data/constants/color_constant.dart';
import '../../../../data/constants/constant.dart';

class ChecklistAddLicenseView extends GetView<ChecklistLicenseInfoController> {
  const ChecklistAddLicenseView({
    super.key,
    this.isVDL,
    this.item,
  });

  final bool? isVDL;
  final License? item;

  @override
  Widget build(BuildContext context) {
    controller.updateModel.value = item;
    controller.assignAllField();
    double width = Get.width;
    bool isCDL = !(isVDL ?? false);
    controller.isCDL = isCDL;
    return Scaffold(
      appBar: CommonAppBar(
          context: context,
          title: isCDL
              ? "Competent Driving License".tr
              : "Vocational Driving License".tr),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.0.height,
                RegisterChecklistHeaderWidget(
                    icon: FontAwesomeIcons.idCardClip,
                    title: isCDL ? "CDL License Info".tr : "VDL License Info".tr,
                    subtitle:
                        "We need your Driving License info. You can add more than one license.".tr),
                30.0.height,
                Text("License Class".tr),
                10.0.height,
                CommonTextField(
                        hintText: 'Tap to select license class'.tr,
                        enabled: false,
                        textEditingController:
                            controller.licenseClassTextController,
                        title: "License Class".tr)
                    .onTap(() {
                  Get.bottomSheet(
                    BottomSheetChooseLicenseClass(
                      isCDL: isCDL,
                    ),
                  );
                }),
                // 20.0.height,
                // const Text("License Number"),
                // 10.0.height,
                // CommonTextField(
                //   hintText: "Your license number",
                //   title: "License Number",
                //   textEditingController: controller.licenseNoTextController,
                // ),
                20.0.height,
                Text("License Expiry Date".tr),
                10.0.height,
                Form(
                  key: controller.dateFormKey,
                  child: CommonTextField(
                    hintText: "Your license expiry date".tr,
                    title: "License Expiry Date".tr,
                    textEditingController:
                        controller.licenseExpiryTextController,
                    enabled: false,
                  ).onTap(() {
                    controller.pickDate();
                  }),
                ),
                20.0.height,
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                20.0.height,
                Row(
                  children: [
                    Text(
                      "License Front".tr,
                      style:
                          context.textTheme.headline3!.copyWith(fontSize: 17),
                    ),
                    Text(
                      " (${'Required'.tr})",
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.orange, fontSize: 14),
                    ),
                  ],
                ),
                5.0.height,
                Text(
                    "Photo of the License must be clearly visible. Scanned or photocopied is not accepted as well.".tr),
                20.0.height,
                SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      CommonImagePlaceholder(
                        imageString: item?.licensePhoto ?? '',
                        imageFile: controller.licenseImage,
                      ),
                      10.0.height,
                      SizedBox(
                        width: width * 0.4,
                        child: CommonButton(
                          title: "Take Photo".tr,
                          callBack: () {
                            CommonService.pickImageC(image: (_) {
                              controller.licenseImage.value = _;
                            });
                          },
                          border: Colors.grey[400],
                          buttonTextColor: ColorConstant.primaryColor,
                          buttonColor: Colors.white,
                          iconData: FontAwesomeIcons.camera,
                        ),
                      ),
                      10.0.height,
                      SizedBox(
                        width: width * 0.4,
                        child: CommonButton(
                          title: "Upload".tr,
                          callBack: () {
                            CommonService.pickImage(image: (_) {
                              controller.licenseImage.value = _;
                            });
                          },
                          border: Colors.grey[400],
                          buttonTextColor: ColorConstant.primaryColor,
                          buttonColor: Colors.white,
                          iconData: FontAwesomeIcons.upload,
                        ),
                      ),
                    ],
                  ),
                ),
                60.0.height,
              ],
            ).paddingSymmetric(horizontal: width * 0.04),
          ),
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
              bool formValid = controller.formKey.currentState!.validate();
              bool dateValid = controller.dateFormKey.currentState!.validate();

              if (formValid && dateValid) {
                controller.submitLicense();
              }
            }),
      ),
    );
  }
}

class BottomSheetChooseLicenseClass
    extends GetView<ChecklistLicenseInfoController> {
  const BottomSheetChooseLicenseClass({
    super.key,
    required this.isCDL,
  });

  final bool isCDL;

  @override
  Widget build(BuildContext context) {
    log("xxx isCDl $isCDL");
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
            Row(
              children: [
                Text(
                  "License Class",
                  style: context.textTheme.headline3!.copyWith(fontSize: 20),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: ColorConstant.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.check,
                        size: 13,
                        color: Colors.white,
                      ),
                      5.0.width,
                      Text(
                        "Done",
                        style: context.textTheme.headline6!
                            .copyWith(color: ColorConstant.white),
                      ),
                    ],
                  ),
                ).onTap(() => dismissBottomSheet())
              ],
            ),
            10.0.height,
            Text(
              "Please select at least one license class. You can choose multiple license based on official driving license",
              style: context.textTheme.headline6!.copyWith(color: Colors.grey),
            ),
            10.0.height,
            isCDL
                ? Expanded(
                    child: ListView.builder(
                        itemCount: controller.licenseClassList.length,
                        itemBuilder: (_, index) {
                          var item =
                              controller.licenseClassList.elementAt(index);

                          return Obx(() {
                            RxBool isSelected = RxBool(controller
                                .addedLicense(item));
                            return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: Row(
                                          children: [
                                            Text(
                                              item.name ?? '',
                                              style:
                                                  context.textTheme.headline3!,
                                            ),
                                            const Spacer(),
                                            Obx(() {
                                              return isSelected.isTrue
                                                  ? const Icon(
                                                      FontAwesomeIcons
                                                          .circleCheck,
                                                    )
                                                  : const SizedBox.shrink();
                                            })
                                          ],
                                        )
                                            .paddingSymmetric(vertical: 10)
                                            .onTap(() {
                                          if (isSelected.isTrue) {
                                            controller.deleteLicense(item);
                                          } else {
                                            controller.multiLicenseClassSelected.add(item);
                                          }

                                          controller.setLicenseTextField();
                                        }),
                                      ),
                                      Divider(
                                        color: Colors.grey[300],
                                        thickness: 0.5,
                                      )
                                    ],
                                  );
                          });
                        }),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: controller.vLicenseClassList.length,
                        itemBuilder: (_, index) {
                          var item =
                              controller.vLicenseClassList.elementAt(index);

                          return Obx(() {
                            RxBool isSelected = RxBool(controller
                                .multiLicenseClassSelected
                                .contains(item));
                            return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: Row(
                                          children: [
                                            Text(
                                              item.name ?? '',
                                              style:
                                                  context.textTheme.headline3!,
                                            ),
                                            const Spacer(),
                                            Obx(() {
                                              return isSelected.isTrue
                                                  ? const Icon(
                                                      FontAwesomeIcons
                                                          .circleCheck,
                                                    )
                                                  : const SizedBox.shrink();
                                            })
                                          ],
                                        )
                                            .paddingSymmetric(vertical: 10)
                                            .onTap(() {
                                          if (isSelected.isTrue) {
                                            controller.multiLicenseClassSelected
                                                .remove(item);
                                          } else {
                                            controller.multiLicenseClassSelected
                                                .add(item);
                                          }

                                          controller.setLicenseTextField();
                                        }),
                                      ),
                                      Divider(
                                        color: Colors.grey[300],
                                        thickness: 0.5,
                                      )
                                    ],
                                  );
                          });
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
