import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/datetime_extensions.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_vehicle_info_status_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/vehicle_info_update_param_model.dart';
import 'package:hero/app/data/models/misc_models/dropdown_model.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';
import 'package:hero/app/data/repositories/misc_repositories/misc_repository.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';

class ChecklistVehicleInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dateFormKey = GlobalKey<FormState>();

  final transportationList = <DropdownModel>[].obs;

  final transportationSelected = Rxn<DropdownModel>();

  final vehicleInfoModel = VehicleInfoStatusModel().obs;

  final isLoading = false.obs;

  final roadTaxExpiryTextController = TextEditingController();
  final modelTextController = TextEditingController();
  final plateNumberTextController = TextEditingController();
  final colorTextController = TextEditingController();
  final yearTextController = TextEditingController();

  final vehicleImage = Rxn<File>();
  final roadTaxImage = Rxn<File>();

  final updateModel = Rxn<Transportation>();

  @override
  void onInit() {
    super.onInit();
    fetchVehicleInfo();
    fetchTransportationType();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> submitVehicleInfo() async {
    try {
      if ((vehicleImage.value == null &&
              (updateModel.value?.transportationPhoto == null)) &&
          (roadTaxImage.value == null &&
              (updateModel.value?.roadTaxPhoto == null))) {
        showRequiredDocImageDialog();
        return;
      }

      showLoading();
      VehicleInfoUpdateParamModel param = VehicleInfoUpdateParamModel();
      param.year = yearTextController.text.trim();
      param.model = modelTextController.text;
      param.plateNumber = plateNumberTextController.text.trim();
      param.color = colorTextController.text.trim();
      param.roadTaxExpiryDate = roadTaxExpiryTextController.text;
      param.roadTaxPhoto = roadTaxImage.value;
      param.transportationPhoto = vehicleImage.value;
      param.transportationTypeId = transportationSelected.value?.uuid ?? '';

      dio.Response response;
      if (updateModel.value != null) {
        param.uuid = updateModel.value?.uuid ?? '';
        response = await RegisterChecklistRepository.instance
            .vehicleInfoUpdate(param: param);
      } else {
        response = await RegisterChecklistRepository.instance
            .vehicleInfoAdd(param: param);
      }

      dismissDialog();
      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      fetchVehicleInfo();
      Get.find<RegisterChecklistController>().fetchChecklistStatus();

      Get.back();
    } catch (error, st) {
      log("xxx $error $st");
      dismissDialog();
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }

  void assignTextField() {
    var item = updateModel.value;
    yearTextController.text = item?.year ?? '';
    modelTextController.text = item?.model ?? '';
    plateNumberTextController.text = item?.plateNumber ?? '';
    colorTextController.text = item?.color ?? '';
    roadTaxExpiryTextController.text = item?.roadTaxExpiryDate ?? '';
    transportationSelected.value = transportationList.firstWhereOrNull(
        (element) => element.name == item?.transportationType);
  }

  Future<void> fetchTransportationType() async {
    try {
      transportationList(await MiscRepository.instance.getTransportationType());
    } catch (error, st) {
      log("xxx $error $st");
    }
  }

  Future<void> fetchVehicleInfo() async {
    try {
      isLoading(true);
      vehicleInfoModel(
          await RegisterChecklistRepository.instance.getVehicleInfoStatus());
    } catch (error, st) {
      log("xxx $error $st");
      snackBarFailed(
          context: Get.context!,
          content: "Failed to get data! Please try again later");
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteVehicle() async {
    try {
      showLoading();
      dio.Response response = await RegisterChecklistRepository.instance
          .vehicleInfoDelete(uuid: updateModel.value?.uuid ?? '');

      dismissDialog();
      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      fetchVehicleInfo();
      Get.back();

      return true;
    } catch (error, st) {
      log("xxx $error $st");
      dismissDialog();
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);

      return false;
    }
  }

  Future<bool> deleteVehicleImage() async {
    try {
      showLoading();
      dio.Response response = await RegisterChecklistRepository.instance
          .vehicleRemoveImage(uuid: updateModel.value?.uuid ?? '');

      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      return true;
    } catch (error, st) {
      log("xxx $error $st");
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);

      return false;
    }finally{
      dismissDialog();
    }
  }

  Future<bool> deleteRoadTaxImage() async {
    try {
      showLoading();
      dio.Response response = await RegisterChecklistRepository.instance
          .vehicleRemoveRoadTaxImage(uuid: updateModel.value?.uuid ?? '');

      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      return true;
    } catch (error, st) {
      log("xxx $error $st");
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);

      return false;
    }finally{
      dismissDialog();
    }
  }

  Future<DateTime?> pickDate() async {
    final newDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    roadTaxExpiryTextController.text = newDate.getDateAPIOnly();

    dateFormKey.currentState!.validate();

    return newDate;
  }

  void clearAllField() {
    roadTaxExpiryTextController.clear();
    modelTextController.clear();
    plateNumberTextController.clear();
    colorTextController.clear();
    yearTextController.clear();
    vehicleImage.value = null;
    roadTaxImage.value = null;
    transportationSelected.value = null;
    updateModel.value = null;
  }
}
