import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/datetime_extensions.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/modules/jobs/controllers/jobs_controller.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_license_info_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_vehicle_info_view.dart';
import 'package:hero/app/routes/app_pages.dart';

import '../../../core/services/common_services.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_dropdown_widget.dart';
import '../../../core/widgets/common_image_placeholder.dart';
import '../../../core/widgets/common_widget.dart';
import '../../../core/widgets/custom_bottom_sheet.dart';
import '../../../data/constants/color_constant.dart';
import '../../../data/models/jobs_models/job_details_model.dart';
import '../../../data/repositories/job_repositories/job_repository.dart';

class AssignedJobDetailsController extends GetxController {
  final merchantList = ["NINJAVAN", "SHOPEE", "LAZADA"].obs;

  final merchantSelected = Rxn<String>();

  final parcelCountList = ["20", "40", "60"].obs;

  final parcelCountSelected = Rxn<String>();

  final jobModel = JobDetailsModel().obs;
  final isLoading = false.obs;

  final isApplyLoading = false.obs;

  String? jobUUID;

  final podImage = Rxn<File>();

  final parcelReceivedTextController = TextEditingController();
  final parcelDeliveredTextController = TextEditingController();
  final jobDateTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments["uuid"] != null) {
        jobUUID = Get.arguments["uuid"];
      }
    }

    fetchJobDetail();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool canCancelAssignment(int assignment) {
    return assignment == 5 || assignment == 7 || assignment == 12;
  }

  bool canQuitAssignment(int assignment) {
    return assignment == 3 || assignment == 4;
  }

  Future<void> quitAssignment() async {
    try {
      showLoading();
      await JobRepository.instance
          .quitAssignment(jobUUID: jobModel.value.uuid ?? '');
      dismissDialog();
      snackBarSuccess(
          context: Get.context!, content: 'Quit assignment success');
      JobsController jobsController = Get.find<JobsController>();
      jobsController.fetchAssignedJob();
      Get.back();
    } catch (error, st) {
      dismissDialog();
      snackBarFailed(
          context: Get.context!,
          content: 'Unable to process you request. Please try again later');
    }
  }

  Future<DateTime?> pickDate({required bool isPOA}) async {
    log('xxxxx date 14 days ago : ${DateTime(DateTime.now().day - 14)}');
    final newDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 14)),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            useMaterial3: true,
            colorScheme:
                const ColorScheme.light(primary: ColorConstant.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            textTheme: context.textTheme,
          ),
          child: child!,
        );
      },
    );

    if (newDate == null) return null;

    jobDateTextController.text = newDate.getDateAPIOnly();

    return newDate;
  }

  Future<void> submitPODBottomSheet({PodList? pod}) async {
    final isNoParcel = false.obs;
    await openBottomSheet(children: [
      Center(
        child: Text(
          pod != null ? pod.jobCode ?? '' : "New POD".tr,
          style: Get.context!.textTheme.headline3!.copyWith(color: Colors.grey),
        ),
      ),
      20.0.height,
      Row(
        children: [
          Text(
            "Proof of Delivery".tr,
            style: Get.context!.textTheme.headline3!.copyWith(fontSize: 17),
          ),
          Text(
            " (${'Required'.tr})*",
            style: Get.context!.textTheme.headline6!
                .copyWith(color: Colors.orange, fontSize: 17),
          ),
        ],
      ),
      5.0.height,
      Text("Photo of POD Slip must be clearly visible.".tr),
      20.0.height,
      SizedBox(
        width: Get.width,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Obx(() {
                return isNoParcel.isTrue
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          CommonImagePlaceholder(
                            imageString: (pod?.podImageUrl ?? ''),
                            imageFile: podImage,
                          ),
                          10.0.height,
                          SizedBox(
                            width: Get.width * 0.4,
                            child: CommonButton(
                              title: "Take Photo".tr,
                              callBack: () {
                                CommonService.pickImageC(image: (_) {
                                  podImage.value = _;
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
                            width: Get.width * 0.4,
                            child: CommonButton(
                              title: "Upload".tr,
                              callBack: () {
                                CommonService.pickImage(image: (_) {
                                  podImage.value = _;
                                });
                              },
                              border: Colors.grey[400],
                              buttonTextColor: ColorConstant.primaryColor,
                              buttonColor: Colors.white,
                              iconData: FontAwesomeIcons.upload,
                            ),
                          ),
                          10.0.height,
                        ],
                      );
              }),
              Row(
                children: [
                  Obx(() {
                    return Checkbox(
                      value: isNoParcel.value,
                      onChanged: (_) => isNoParcel.value = _ ?? false,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }),
                  Text('No Parcel Available'.tr)
                ],
              ),
              10.0.height,
              Obx(() {
                return isNoParcel.isTrue
                    ? const SizedBox.shrink()
                    : Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Parcel Received".tr,
                                  style: Get.context!.textTheme.headline6!
                                      .copyWith(
                                          color: Colors.grey, fontSize: 13),
                                ),
                                5.0.height,
                                CommonTextField(
                                    hintText: "Parcel Received".tr,
                                    textEditingController:
                                        parcelReceivedTextController,
                                    type: TextFieldType.PHONE,
                                    title: "Parcel Received".tr),
                              ],
                            ),
                          ),
                          isNoParcel.isTrue
                              ? const SizedBox.shrink()
                              : 10.0.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Parcel Delivered".tr,
                                  style: Get.context!.textTheme.headline6!
                                      .copyWith(
                                          color: Colors.grey, fontSize: 13),
                                ),
                                5.0.height,
                                CommonTextField(
                                    hintText: "Parcel Delivered".tr,
                                    textEditingController:
                                        parcelDeliveredTextController,
                                    type: TextFieldType.PHONE,
                                    title: "Parcel Delivered".tr),
                              ],
                            ),
                          ),
                        ],
                      );
              }),
              20.0.height,
              Row(
                children: [
                  Text(
                    "Job Date".tr,
                    style: Get.context!.textTheme.headline6!
                        .copyWith(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              5.0.height,
              CommonTextField(
                      hintText: "Job Date".tr,
                      textEditingController: jobDateTextController,
                      enabled: false,
                      title: "Job Date".tr)
                  .onTap(() => pickDate(isPOA: false)),
              20.0.height,
              CommonButton(
                  title: "Submit".tr,
                  callBack: () async {
                    if ((formKey.currentState?.validate() ?? false)) {
                      try {
                        showLoading();
                        await JobRepository.instance.submitPOD(
                            jobUUID: jobUUID ?? '',
                            podImage: podImage.value,
                            jobDate: jobDateTextController.text,
                            parcelReceived: parcelReceivedTextController.text,
                            parcelDelivered: parcelDeliveredTextController.text,
                            noParcel: isNoParcel.value);

                        dismissDialog();
                        fetchJobDetail();
                        dismissBottomSheet();
                      } catch (error, st) {
                        dismissDialog();
                        toastFailed(
                            context: Get.context!,
                            content: error is CustomException
                                ? error.message
                                : error.toString().removeException);
                      }
                    }
                  }),
              20.0.height,
            ],
          ),
        ),
      )
    ], title: "Submit POD");

    podImage.value = null;
    parcelDeliveredTextController.clear();
    parcelReceivedTextController.clear();
    jobDateTextController.clear();
  }

  Future<void> submitPOABottomSheet({PodList? pod}) async {
    final isChecked = false.obs;
    await openBottomSheet(children: [
      Center(
        child: Text(
          "New POA".tr,
          style: Get.context!.textTheme.headline3!.copyWith(color: Colors.grey),
        ),
      ),
      20.0.height,
      Row(
        children: [
          Text(
            "Proof of Attendance".tr,
            style: Get.context!.textTheme.headline3!.copyWith(fontSize: 17),
          ),
          Text(
            " (${'Required'.tr})*",
            style: Get.context!.textTheme.headline6!
                .copyWith(color: Colors.orange, fontSize: 17),
          ),
        ],
      ),
      SizedBox(
        width: Get.width,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              10.0.height,
              SizedBox(
                height: Get.height * 0.4,
                child: Row(
                  children: [
                    Obx(() {
                      return Checkbox(
                        value: isChecked.value,
                        onChanged: (_) {
                          isChecked.value = _ ?? false;
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "By checking this box, I acknowledge the following:",
                              style: Get.context!.textTheme.headline3,
                            ),
                            Text('\n1. I confirmed my arrival for work today.'),
                            Text(
                              'Saya mengesahkan kehadiran saya bekerja pada hari ini.',
                              style: Get.context!.textTheme.headline6!
                                  .copyWith(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                                '\n2. I have performed my duties today in accordance with the established procedures.'),
                            Text(
                              'Saya telah menjalankan tugas saya hari ini mengikut prosedur yang ditetapkan.',
                              style: Get.context!.textTheme.headline6!
                                  .copyWith(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                                "\n3. I understand that this acknowledgement does not limit Carpedia's responsibility for following applicable laws and regulations."),
                            Text(
                              'Saya faham bahawa pengiktirafan ini tidak mengehadkan tanggungjawab Carpedia untuk mematuhi undang-undang dan peraturan yang berkenaan.',
                              style: Get.context!.textTheme.headline6!
                                  .copyWith(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                                "\n4. I understand that any claims of negligence or misconduct will be addressed according to Carpedia's internal policies and procedures."),
                            Text(
                              'Saya faham bahawa sebarang tuntutan kecuaian atau salah laku akan ditangani mengikut dasar dan prosedur dalaman Carpedia',
                              style: Get.context!.textTheme.headline6!
                                  .copyWith(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.0.height,
              Row(
                children: [
                  Text(
                    "Job Date".tr,
                    style: Get.context!.textTheme.headline6!
                        .copyWith(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              5.0.height,
              CommonTextField(
                      hintText: "Job Date".tr,
                      textEditingController: jobDateTextController,
                      enabled: false,
                      title: "Job Date".tr)
                  .onTap(() => pickDate(isPOA: true)),
              20.0.height,
              CommonButton(
                  title: "Submit".tr,
                  callBack: () async {
                    if ((formKey.currentState?.validate() ?? false)) {
                      if (isChecked.isTrue) {
                        try {
                          showLoading();
                          await JobRepository.instance.submitPOD(
                              jobUUID: jobUUID ?? '',
                              podImage: podImage.value,
                              jobDate: jobDateTextController.text,
                              parcelReceived: parcelReceivedTextController.text,
                              parcelDelivered:
                                  parcelDeliveredTextController.text,
                              noParcel: false);

                          dismissDialog();
                          fetchJobDetail();
                          dismissBottomSheet();
                        } catch (error, st) {
                          dismissDialog();
                          toastFailed(
                              context: Get.context!,
                              content: error is CustomException
                                  ? error.message
                                  : error.toString().removeException);
                        }
                      } else {
                        toastFailed(
                            context: Get.context!,
                            content: "Read carefully and complete all form above".tr);
                      }
                    }
                  }),
              20.0.height,
            ],
          ),
        ),
      )
    ], title: "Submit a POA".tr);

    podImage.value = null;
    parcelDeliveredTextController.clear();
    parcelReceivedTextController.clear();
    jobDateTextController.clear();
  }

  Future<void> fetchJobDetail() async {
    try {
      isLoading(true);
      jobModel(await JobRepository.instance
          .getAssignedJobDetail(jobUUID: jobUUID ?? ''));
    } catch (error, st) {
      log("xxxx $error $st");
      snackBarFailed(context: Get.context!, content: error.toString());
    } finally {
      isLoading(false);
    }
  }

  String getRequirementType(String type) {
    switch (type) {
      case 'license_types':
        return "License required".tr;
      case 'transportation_types':
        return "Transportation required".tr;
      case 'onboarding_checklist':
        return "Onboarding required".tr;
    }
    return "";
  }

  void routeToChecklist(String type) {
    switch (type) {
      case 'license_types':
        Get.to(ChecklistLicenseInfoView());
        break;
      case 'transportation_types':
        Get.to(ChecklistVehicleInfoView());
        break;
      case 'onboarding_checklist':
        Get.toNamed(Routes.ONBOARDING,
            arguments: {"assignment": jobModel.value.uuid ?? ''});
    }
  }
}
