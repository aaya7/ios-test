import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/data/constants/extensions/datetime_extensions.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/data/models/jobs_models/job_details_model.dart';
import 'package:hero/app/data/models/jobs_models/pod_detail_model.dart';
import 'package:hero/app/data/repositories/job_repositories/job_repository.dart';
import 'package:hero/app/modules/assigned_job_details/controllers/assigned_job_details_controller.dart';

import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_textfield.dart';
import '../../../core/widgets/custom_bottom_sheet.dart';
import '../../../core/widgets/text_field.dart';
import '../../../data/constants/color_constant.dart';

class PodDetailController extends GetxController {
  String? podUUID;

  final isLoading = false.obs;

  late final Rx<JobDetailsModel> jobModel;

  final podModel = PodDetailModel().obs;

  final parcelReceivedTextController = TextEditingController();
  final parcelDeliveredTextController = TextEditingController();
  final jobDateTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["job"] != null) {
        jobModel = Rx(Get.arguments["job"]);
      }

      if (Get.arguments["uuid"] != null) {
        podUUID = Get.arguments["uuid"];
      }

      log("xxx pod uuid: $podUUID");
      log("xxx job uuid: ${jobModel.value.uuid}");
    }

    fetchPODDetail();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchPODDetail() async {
    try {
      isLoading(true);
      podModel(await JobRepository.instance.getPODDetail(
          jobUUID: jobModel.value.uuid ?? '', podUUID: podUUID ?? ''));
    } catch (error, st) {
      log("xxx pod detail $error $st");
      snackBarFailed(
          context: Get.context!,
          content: "Failed to get POD data. Please try again later");
    } finally {
      isLoading(false);
    }
  }

  Future<void> deletePOD() async {
    try {
      showLoading();
      dio.Response response = await JobRepository.instance.deletePOD(
          jobUUID: jobModel.value.uuid ?? '', podUUID: podUUID ?? '');

      dismissDialog();
      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      Get.find<AssignedJobDetailsController>().fetchJobDetail();
      Get.back();
    } catch (error, st) {
      dismissDialog();
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }

  Future<DateTime?> pickDate() async {
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

  Future<void> submitPODBottomSheet() async {
    jobDateTextController.text = podModel.value.jobDate ?? '';
    parcelDeliveredTextController.text =
        (podModel.value.parcelsDeliveredCount ?? 0).toString();
    parcelReceivedTextController.text =
        (podModel.value.parcelsReceivedCount ?? 0).toString();

    await openBottomSheet(children: [
      Center(
        child: Text(
          podModel.value.jobCode ?? '',
          style: Get.context!.textTheme.headline3!.copyWith(color: Colors.grey),
        ),
      ),
      20.0.height,
      SizedBox(
        width: Get.width,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              20.0.height,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Parcel Received".tr,
                          style: Get.context!.textTheme.headline6!
                              .copyWith(color: Colors.grey, fontSize: 13),
                        ),
                        5.0.height,
                        CommonTextField(
                            hintText: "Parcel Received".tr,
                            textEditingController: parcelReceivedTextController,
                            type: TextFieldType.PHONE,
                            title: "Parcel Received".tr),
                      ],
                    ),
                  ),
                  10.0.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Parcel Delivered".tr,
                          style: Get.context!.textTheme.headline6!
                              .copyWith(color: Colors.grey, fontSize: 13),
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
              ),
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
                  .onTap(() => pickDate()),
              20.0.height,
              CommonButton(
                  title: "Submit".tr,
                  callBack: () async {
                    if ((formKey.currentState?.validate() ?? false)) {
                      try {
                        showLoading();
                        await JobRepository.instance.updatePOD(
                            jobUUID: jobModel.value.uuid ?? '',
                            podUUID: podUUID ?? '',
                            jobDate: jobDateTextController.text,
                            parcelReceived: parcelReceivedTextController.text,
                            parcelDelivered:
                                parcelDeliveredTextController.text);

                        dismissDialog();
                        Get.find<AssignedJobDetailsController>()
                            .fetchJobDetail();
                        fetchPODDetail();
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
    ], title: "Submit a POD".tr);
  }
}
