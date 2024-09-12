import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_image_placeholder.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/register_checklist_header_widget.dart';
import 'package:hero/app/core/widgets/shimmer/shimmerlistview.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_vehicle_info_status_model.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_vehicle_info_controller.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_add_license_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/widgets/common_dropdown_widget.dart';
import '../../../../core/widgets/info_dialog.dart';
import '../../../../data/constants/color_constant.dart';
import '../../../../data/constants/constant.dart';

class ChecklistAddVehicleInfoView
    extends GetView<ChecklistVehicleInfoController> {
  const ChecklistAddVehicleInfoView({super.key, this.item});

  final Transportation? item;

  @override
  Widget build(BuildContext context) {
    controller.updateModel.value = item;
    controller.assignTextField();
    double width = Get.width;
    return Scaffold(
      appBar:
          CommonAppBar(context: context, title: "Vehicle Information".tr, action: [
        item != null
            ? IconButton(
                onPressed: () {
                  Get.dialog(
                    InfoDialog(
                      title: "${'Delete'.tr} ${item?.plateNumber ?? ''}",
                      info:
                      "Are you sure want to delete this vehicle? All data for this vehicle will permanently deleted.".tr,
                      confirmText: "Delete".tr.toUpperCase(),
                      icon: LottieBuilder.asset(
                        "assets/lottie/delete.json",
                        height: 100,
                      ),
                      confirmButtonColor: Colors.redAccent,
                      confirmCallback: () {
                        dismissDialog();
                        controller.deleteVehicle();

                      },
                      cancelText: "Cancel".tr.toUpperCase(),
                    ),
                  );
                },
                icon: const Icon(
                  LineIcons.trash,
                  color: Colors.redAccent,
                ),
              )
            : const SizedBox.shrink()
      ]),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.0.height,
              RegisterChecklistHeaderWidget(
                  icon: FontAwesomeIcons.carSide,
                  title: "Vehicle Information".tr,
                  subtitle:
                      "We need your vehicle information. Please add at least one vehicle".tr),
              30.0.height,
              Text("Vehicle Type".tr),
              5.0.height,
              Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonDropdownWidget(
                        selectedValue: controller.transportationSelected,
                        dropdownList: controller.transportationList,
                        title: "Vehicle Type".tr,
                        onChanged: (_) {
                          controller.transportationSelected.value = _;
                        },
                        displayItem: "name"),
                    20.0.height,
                    Text("Vehicle Model".tr),
                    5.0.height,
                    CommonTextField(
                      hintText: "Vehicle Model".tr,
                      title: "Vehicle Model".tr,
                      textEditingController: controller.modelTextController,
                    ),
                    20.0.height,
                    Text("Plate Number".tr),
                    5.0.height,
                    CommonTextField(
                      hintText: "Plate Number".tr,
                      title: "Plate Number".tr,
                      textEditingController:
                          controller.plateNumberTextController,
                    ),
                    20.0.height,
                    Text("Vehicle Color".tr),
                    5.0.height,
                    CommonTextField(
                      hintText: "Vehicle Color".tr,
                      title: "Vehicle Color".tr,
                      textEditingController: controller.colorTextController,
                    ),
                    20.0.height,
                    Text("Vehicle Year".tr),
                    5.0.height,
                    CommonTextField(
                      hintText: "Vehicle Year".tr,
                      title: "Vehicle Year".tr,
                      type: TextFieldType.PHONE,
                      textEditingController: controller.yearTextController,
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
                          "Vehicle Image".tr,
                          style: context.textTheme.headline3!
                              .copyWith(fontSize: 17),
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
                        "Photo of your vehicle must be clearly visible.".tr),
                    20.0.height,
                    SizedBox(
                      width: width,
                      child: Column(
                        children: [
                          CommonImagePlaceholder(
                            imageString: item?.transportationPhoto ?? '',
                            imageFile: controller.vehicleImage,
                            deleteCallback: (_)async{
                              if(controller.vehicleImage.value != null){
                                return true;
                              }

                              return await controller.deleteVehicleImage();
                            },
                          ),
                          10.0.height,
                          SizedBox(
                            width: width * 0.4,
                            child: CommonButton(
                              title: "Take Photo".tr,
                              callBack: () {
                                CommonService.pickImageC(image: (_) {
                                  controller.vehicleImage.value = _;
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
                                  controller.vehicleImage.value = _;
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
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    20.0.height,
                    Row(
                      children: [
                        Text(
                          "Road Tax".tr,
                          style: context.textTheme.headline3!
                              .copyWith(fontSize: 17),
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
                        "Photo of the Road Tax must be clearly visible. Scanned or photocopied image is not accepted.".tr),
                    20.0.height,
                    SizedBox(
                      width: width,
                      child: Column(
                        children: [
                          CommonImagePlaceholder(
                            imageString: item?.roadTaxPhoto ?? '',
                            imageFile: controller.roadTaxImage,
                            deleteCallback: (_)async{
                              if(controller.roadTaxImage.value != null){
                                return true;
                              }

                              return await controller.deleteRoadTaxImage();
                            },
                          ),
                          10.0.height,
                          SizedBox(
                            width: width * 0.4,
                            child: CommonButton(
                              title: "Take Photo".tr,
                              callBack: () {
                                CommonService.pickImageC(image: (_) {
                                  controller.roadTaxImage.value = _;
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
                                  controller.roadTaxImage.value = _;
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
                  ],
                ),
              ),
              20.0.height,
              Text("Road Tax Expiry Date".tr),
              5.0.height,
              Form(
                key: controller.dateFormKey,
                child: CommonTextField(
                        hintText: "Tap to choose date".tr,
                        enabled: false,
                        textEditingController:
                            controller.roadTaxExpiryTextController,
                        title: "Road Tax Expiry Date".tr)
                    .onTap(() => controller.pickDate()),
              ),
              60.0.height,
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
            title: "Continue".tr,
            callBack: () {
              bool form = controller.formKey.currentState!.validate();
              bool dateForm = controller.dateFormKey.currentState!.validate();

              if (form && dateForm) {
                controller.submitVehicleInfo();
              }
            }),
      ),
    );
  }
}
