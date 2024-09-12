import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/datetime_extensions.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_license_info_model.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';
import 'package:hero/app/data/repositories/misc_repositories/misc_repository.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';

import '../../../data/models/misc_models/dropdown_model.dart';

class ChecklistLicenseInfoController extends GetxController {
  final licenseTypeList = [
    "Competent Driving License (CDL)",
    "Vocational Driving License (VDL)"
  ].obs;

  final licenseTypeSelected = Rxn<String>();

  final licenseClassList = <DropdownModel>[].obs;

  final multiLicenseClassSelected = RxList<DropdownModel>();

  final vLicenseClassList = <DropdownModel>[].obs;

  final formKey = GlobalKey<FormState>();
  final dateFormKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  final licenseInfoStatus = LicenseInfoStatusModel().obs;

  final licenseClassTextController = TextEditingController();
  final licenseExpiryTextController = TextEditingController();
  final licenseNoTextController = TextEditingController();

  final licenseImage = Rxn<File>();

  final updateModel = Rxn<License>();

  bool isCDL = false;

  @override
  void onInit() {
    super.onInit();
    fetchLicenseInfoStatus();
    fetchLicenseClass();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchLicenseInfoStatus() async {
    try {
      isLoading(true);
      licenseInfoStatus(
          await RegisterChecklistRepository.instance.getLicenseInfoStatus());
    } catch (error, st) {
      log("xxx $error $st");
      snackBarFailed(
          context: Get.context!,
          content: "Failed to get data! Please try again later");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchLicenseClass() async {
    try {
      licenseClassList(await MiscRepository.instance.getCDLLicenseType());
      vLicenseClassList(await MiscRepository.instance.getVDLLicenseType());

      for (var added in updateModel.value?.licenseClasses ?? <LicenseClass>[]) {
        if (isCDL) {
          for (var item in licenseClassList) {
            if (added.licenseType == item.name) {
              multiLicenseClassSelected.add(DropdownModel(
                  uuid: added.licenseTypeUuid, name: added.licenseType));
            }
          }
        } else {
          for (var item in vLicenseClassList) {
            if (added.licenseType == item.name) {
              multiLicenseClassSelected.add(DropdownModel(
                  uuid: added.licenseTypeUuid, name: added.licenseType));
            }
          }
        }
      }
    } catch (error, st) {
      log("xxx fetch License class $error $st");
    }
  }

  String joinModelList(List<LicenseClass> items) {
    List<String> names = items.map((item) => (item.licenseType ?? '')).toList();

    if (names.isEmpty) {
      return "No license class added";
    } else {
      return names.join(', ');
    }
  }

  void setLicenseTextField() {
    String text = "";
    for (int x = 0; x < multiLicenseClassSelected.length; x++) {
      text = "$text${x == 0 ? "" : ","} ${multiLicenseClassSelected[x].name} ";
    }

    licenseClassTextController.text = text;
    try {
      formKey.currentState!.validate();
    } catch (error) {}
  }

  bool addedLicense(DropdownModel item) {
    for (var added in multiLicenseClassSelected) {
      if (added.name == item.name) {
        return true;
      }
    }
    return false;
  }

  void deleteLicense(DropdownModel item) {
    for (int x = 0; x < multiLicenseClassSelected.length; x++) {
      if (multiLicenseClassSelected[x].name == item.name) {
        multiLicenseClassSelected.removeAt(x);
        return;
      }
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

    licenseExpiryTextController.text = newDate.getDateAPIOnly();

    dateFormKey.currentState!.validate();

    return newDate;
  }

  void clearAllField() {
    licenseClassTextController.clear();
    licenseExpiryTextController.clear();
    licenseNoTextController.clear();
    licenseImage.value = null;
    updateModel.value = null;
    multiLicenseClassSelected.clear();
  }

  Future<void> submitLicense() async {
    try {
      if (licenseImage.value == null &&
          updateModel.value?.licensePhoto == null) {
        showRequiredDocImageDialog();
        return;
      }

      showLoading();
      dio.Response response;
      if (isCDL) {
        response = await RegisterChecklistRepository.instance.licenseCDLUpdate(
            licenseNumber: licenseNoTextController.text.trim(),
            expiry: licenseExpiryTextController.text,
            licensePhoto: licenseImage.value);
      } else {
        response = await RegisterChecklistRepository.instance.licenseVDLUpdate(
            licenseNumber: licenseNoTextController.text.trim(),
            expiry: licenseExpiryTextController.text,
            licensePhoto: licenseImage.value);
      }

      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      dio.Response addLicenseResponse;

      for (var item in recentAddLicenseClass()) {
        if (isCDL) {
          try {
            addLicenseResponse = await RegisterChecklistRepository.instance
                .licenseCDLAdd(licenseUUID: item.uuid ?? '');
          } catch (error) {}
        } else {
          try {
            addLicenseResponse = await RegisterChecklistRepository.instance
                .licenseVDLAdd(licenseUUID: item.uuid ?? '');
          } catch (error) {}
        }
      }

      for (var item in recentDeleteLicenseClass()) {

          try {
            dio.Response deleteLicense = await RegisterChecklistRepository.instance
                .licenseClassDelete(licenseUUID: item.uuid ?? '');
          } catch (error) {}

      }

      dismissDialog();

      fetchLicenseInfoStatus();

      Get.find<RegisterChecklistController>().fetchChecklistStatus();

      Get.back();
    } catch (error, st) {
      dismissDialog();
      log("xxx submit license $error $st");
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }

  List<DropdownModel> recentAddLicenseClass() {
    var recentAddedLicenses = <DropdownModel>[];

    for (var selectedItem in multiLicenseClassSelected) {
      bool found = false;
      for (var updateItem
          in updateModel.value?.licenseClasses ?? <LicenseClass>[]) {
        if (selectedItem.name == updateItem.licenseType) {
          found = true;
          break;
        }
      }

      if(!found){
        recentAddedLicenses.add(selectedItem);
      }
    }

    return recentAddedLicenses;
  }

  List<DropdownModel> recentDeleteLicenseClass() {
    var recentDeleteLicenses = <DropdownModel>[];

    for (var updateItem
        in updateModel.value?.licenseClasses ?? <LicenseClass>[]) {
      bool found = false;
      for (var selectedItem in multiLicenseClassSelected) {
        if (updateItem.licenseType == selectedItem.name) {
          found = true;
          break;

        }
      }
      if(!found){
        recentDeleteLicenses.add(DropdownModel(
            uuid: updateItem.licenseTypeUuid, name: updateItem.licenseType));
      }
    }

    return recentDeleteLicenses;
  }

  Future<void> deleteLicenseClass({required String licenseUUID}) async {
    try {
      dio.Response response = await RegisterChecklistRepository.instance
          .licenseClassDelete(licenseUUID: licenseUUID);

      snackBarSuccess(context: Get.context!, content: response.data["message"]);
    } catch (error, st) {
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }

  void assignAllField() {
    licenseExpiryTextController.text = updateModel.value?.licenseExpiry ?? '';
    licenseNoTextController.text = updateModel.value?.licenseNumber ?? '';

    multiLicenseClassSelected.clear();
    for (final item in updateModel.value?.licenseClasses ?? <LicenseClass>[]) {
      multiLicenseClassSelected.add(
          DropdownModel(uuid: item.licenseTypeUuid, name: item.licenseType));
    }

    setLicenseTextField();
  }
}
