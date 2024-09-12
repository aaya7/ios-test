import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/register_checklist_header_widget.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_personal_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';

import '../../../../core/widgets/common_dropdown_widget.dart';
import '../../../../core/widgets/common_image_placeholder.dart';
import '../../../../data/constants/color_constant.dart';

class ChecklistPersonalInfoView
    extends GetView<ChecklistPersonalInfoController> {
  const ChecklistPersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Personal Information".tr),
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
                    icon: FontAwesomeIcons.idCard,
                    title: "Personal Information".tr,
                    subtitle: "We need your IC and some personal info.".tr),
                30.0.height,
                Text("Full Name".tr),
                5.0.height,
                CommonTextField(
                  hintText: "Your name".tr,
                  title: "Full Name".tr,
                  textEditingController: controller.nameTextEditingController,
                  type: TextFieldType.NAME,
                ),
                20.0.height,
                Text("Email".tr),
                5.0.height,
                CommonTextField(
                  hintText: "Your email address".tr,
                  title: "Email".tr,
                  enabled: false,
                  textEditingController: controller.emailTextEditingController,
                  type: TextFieldType.EMAIL,
                ),
                20.0.height,
                Text("Phone Number".tr),
                5.0.height,
                CommonTextField(
                  hintText: "Your phone number".tr,
                  title: "Phone Number".tr,
                  textEditingController: controller.phoneTextEditingController,
                  type: TextFieldType.PHONE,
                ),
                20.0.height,
                Text("NRIC Number".tr),
                5.0.height,
                CommonTextField(
                  hintText: "Your IC number".tr,
                  title: "NRIC Number".tr,
                  textEditingController: controller.nricTextEditingController,
                  type: TextFieldType.IC,
                ),
                20.0.height,
                Text("Residential Address".tr),
                5.0.height,
                CommonTextField(
                    hintText: "Apartment, Suite, etc".tr,
                    minLines: 4,
                    maxLines: 6,
                    textEditingController:
                        controller.residentialAddressTextEditingController,
                    title: "Residential Address".tr),
                20.0.height,
                Text("State & City".tr),
                10.0.height,
                Row(
                  children: [
                    Expanded(
                      child: CommonDropdownWidget(
                          selectedValue: controller.stateSelected,
                          dropdownList: controller.stateList,
                          title: "State".tr,
                          hintText: "State".tr,
                          onChanged: (_) {
                            controller.stateSelected.value = _;
                            controller.citySelected.value = null;
                            controller.fetchCities(state: _);
                          },
                          displayItem: ""),
                    ),
                    10.0.width,
                    Expanded(
                      child: CommonDropdownWidget(
                          selectedValue: controller.citySelected,
                          dropdownList: controller.cityList,
                          title: "City".tr,
                          hintText: "City".tr,
                          onChanged: (_) {
                            controller.citySelected.value = _;
                          },
                          displayItem: "name"),
                    ),
                  ],
                ),
                20.0.height,
                Text("Postal Code".tr),
                5.0.height,
                CommonTextField(
                  hintText: "i.e. 31350",
                  title: "Postal Code".tr,
                  textEditingController:
                      controller.postalCodeTextEditingController,
                  type: TextFieldType.PHONE,
                  maxLength: 5,
                ),
                20.0.height,
                const Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                20.0.height,
                Row(
                  children: [
                    Text(
                      "NRIC Front".tr,
                      style:
                          context.textTheme.headline3!.copyWith(fontSize: 17),
                    ),
                    Text(
                      " (${'Required'.tr})",
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.orange, fontSize: 17),
                    ),
                  ],
                ),
                5.0.height,
                Text(
                    "Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well.".tr),
                20.0.height,
                SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      Obx(() {
                        return CommonImagePlaceholder(
                          imageString: controller
                                  .personalInfoModel.value.mediaFrontIcUrl ??
                              '',
                          imageFile: controller.frontIcImage,
                          deleteCallback: (_) async {
                            if (controller.frontIcImage.value != null) {
                              return true;
                            }

                            return await controller.deleteNRICImage(
                                isFront: true);
                          },
                        );
                      }),
                      10.0.height,
                      SizedBox(
                        width: width * 0.4,
                        child: CommonButton(
                          title: "Take Photo".tr,
                          callBack: () async {
                            await CommonService.pickImageC(image: (_) {
                              controller.frontIcImage.value = _;
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
                          callBack: () async {
                            await CommonService.pickImage(image: (_) {
                              controller.frontIcImage.value = _;
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
                20.0.height,
                const Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                20.0.height,
                Row(
                  children: [
                    Text(
                      "NRIC Back".tr,
                      style:
                          context.textTheme.headline3!.copyWith(fontSize: 17),
                    ),
                    Text(
                      " (${'Required'.tr})",
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.orange, fontSize: 17),
                    ),
                  ],
                ),
                5.0.height,
                Text(
                    "Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well.".tr),
                20.0.height,
                SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      Obx(() {
                        return CommonImagePlaceholder(
                          imageString: controller
                                  .personalInfoModel.value.mediaBackIcUrl ??
                              '',
                          imageFile: controller.backIcImage,
                          deleteCallback: (_) async {
                            if (controller.backIcImage.value != null) {
                              return true;
                            }

                            return await controller.deleteNRICImage(
                                isFront: false);
                          },
                        );
                      }),
                      10.0.height,
                      SizedBox(
                        width: width * 0.4,
                        child: CommonButton(
                          title: "Take Photo".tr,
                          callBack: () async {
                            await CommonService.pickImageC(image: (_) {
                              controller.backIcImage.value = _;
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
                          callBack: () async {
                            await CommonService.pickImage(image: (_) {
                              controller.backIcImage.value = _;
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
                20.0.height,
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
              if (controller.formKey.currentState!.validate()) {
                controller.submitPersonalInfo();
              }
            }),
      ),
    );
  }
}
