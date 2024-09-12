import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/datetime_extensions.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/repositories/job_repositories/job_repository.dart';
import 'package:hero/app/modules/jobs/controllers/jobs_controller.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/custom_bottom_sheet.dart';
import '../../../data/models/jobs_models/job_details_model.dart';
import '../../../routes/app_pages.dart';
import '../../register_checklist/views/checklist_page/checklist_license_info_view.dart';
import '../../register_checklist/views/checklist_page/checklist_vehicle_info_view.dart';

class JobDetailsController extends GetxController {
  final jobModel = JobDetailsModel().obs;
  final isLoading = false.obs;

  final isApplyLoading = false.obs;

  String? jobUUID;

  final startDateTextController = TextEditingController();

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

  Future<DateTime?> pickDate() async {
    final newDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now().add(3.days),
      firstDate: DateTime.now().add(3.days),
      lastDate: DateTime(DateTime.now().year + 1),
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

    startDateTextController.text = newDate.getDateAPIOnly();

    formKey.currentState?.validate();

    return newDate;
  }

  Future<void> fetchJobDetail() async {
    try {
      isLoading(true);
      jobModel(
          await JobRepository.instance.getJobDetails(jobUUID: jobUUID ?? ''));

      if(!(jobModel.value.canApply ?? true)){
        openBottomSheet(children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/sad.json",
                  width: Get.width * 0.6, fit:  BoxFit.fitWidth),
            ],
          ),

          ListView.builder(
              itemCount: jobModel.value.requirementsString?.length ?? 0,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Text(
                  "- ${jobModel.value.requirementsString?.elementAt(index) ?? ''}\n",
                  // textAlign: TextAlign.center,
                  style: context.textTheme.headline6!
                      .copyWith(color: Colors.black54, fontSize: 16),
                ).paddingSymmetric(horizontal: 10);
              }
          ),
          50.0.height,
        ], title: 'Unable to Apply this Job'.tr);
      }

    } catch (error, st) {
      log("xxxx $error $st");
      snackBarFailed(context: Get.context!, content: error.toString());
    } finally {
      isLoading(false);
    }
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

  String getRequirementType(String type) {
    switch (type) {
      case 'license_types':
        return "License required";
      case 'transportation_types':
        return "Transportation required";
    }
    return "";
  }

  Future<void> applyJob() async {
    try {
      isApplyLoading(true);
      dio.Response response = await JobRepository.instance.applyJob(
          jobUUID: jobUUID ?? '',
          startDate: startDateTextController.text.trim());

      isApplyLoading(false);
      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      Get.find<JobsController>().fetchAssignedJob();

      Get.find<JobsController>().tabController.animateTo(1);

      Get.offNamed(Routes.ASSIGNED_JOB_DETAILS, arguments: {
        "uuid": response.data["assignment"]["uuid"]
      });
    } catch (error, st) {
      isApplyLoading(false);
      log("xxx $error $st");
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }
}
