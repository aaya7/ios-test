import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_personal_info_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/personal_info_update_param_model.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';
import 'package:hero/app/modules/home/controllers/home_controller.dart';
import 'package:hero/app/modules/main/controllers/main_controller.dart';
import 'package:hero/app/modules/profile/controllers/profile_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';
import '../../../core/widgets/common_widget.dart';
import '../../../data/models/misc_models/dropdown_model.dart';
import '../../../data/repositories/misc_repositories/misc_repository.dart';

class ChecklistPersonalInfoController extends GetxController {
  final stateSelected = Rxn<String>();
  final citySelected = Rxn<DropdownModel>();

  final stateList = <String>[].obs;

  final cityList = <DropdownModel>[].obs;

  final personalInfoModel = PersonalInfoStatusModel().obs;

  final postalCodeTextEditingController = TextEditingController();
  final nricTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  final residentialAddressTextEditingController = TextEditingController();

  final frontIcImage = Rxn<File>();
  final backIcImage = Rxn<File>();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    await fetchState();
    fetchPersonalInfoStatus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchState() async {
    try {
      stateList(await MiscRepository.instance.getState());
    } catch (error) {
      snackBarFailed(context: Get.context!, content: "Fail to fetch states");
    }
  }

  Future<void> fetchCities({required String state}) async {
    try {
      cityList(await MiscRepository.instance.getCities(state: state));
    } catch (error) {
      snackBarFailed(context: Get.context!, content: "Fail to fetch cities");
    }
  }

  Future<void> fetchPersonalInfoStatus() async {
    try {
      personalInfoModel(
          await RegisterChecklistRepository.instance.getPersonalInfoStatus());

      nricTextEditingController.text =
          personalInfoModel.value.identificationNo ?? '';
      residentialAddressTextEditingController.text =
          personalInfoModel.value.address ?? '';
      postalCodeTextEditingController.text =
          personalInfoModel.value.postalCode ?? '';

      nameTextEditingController.text = personalInfoModel.value.name ?? '';
      phoneTextEditingController.text = personalInfoModel.value.mobile ?? '';
      emailTextEditingController.text = personalInfoModel.value.email ?? '';

      stateSelected(stateList.firstWhereOrNull(
          (element) => element == personalInfoModel.value.state));
      await fetchCities(state: stateSelected.value ?? '');
      citySelected(cityList.firstWhereOrNull(
          (element) => element.name == personalInfoModel.value.city));
    } catch (error, st) {
      log("xxx fetchPersonalInfoController $error $st");
      snackBarFailed(
          context: Get.context!,
          content: "Failed to fetch data! Please try again later");
    }
  }

  Future<void> submitPersonalInfo() async {
    try {
      showLoading();
      PersonalInfoUpdateParam param = PersonalInfoUpdateParam();
      param.postalCode = postalCodeTextEditingController.text.trim();
      param.city = citySelected.value?.name ?? '';
      param.address = residentialAddressTextEditingController.text;
      param.state = stateSelected.value ?? '';
      param.identificationNo = nricTextEditingController.text;
      param.icBackImage = backIcImage.value;
      param.icFrontImage = frontIcImage.value;
      param.name = nameTextEditingController.text;
      param.mobile = phoneTextEditingController.text;

      dio.Response response = await RegisterChecklistRepository.instance
          .updatePersonalInfo(param: param);

      dismissDialog();

      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      Get.find<RegisterChecklistController>().fetchChecklistStatus();
      Get.find<MainController>().fetchProfile();

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

  Future<bool> deleteNRICImage({required bool isFront}) async {
    try {
      showLoading();
      if (isFront) {
        await RegisterChecklistRepository.instance.personalInfoRemoveFrontIC();
      } else {
        await RegisterChecklistRepository.instance.personalInfoRemoveBackIC();
      }

      Get.find<HomeController>().fetchChecklistStatus();

      return true;
    } catch (error) {
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
      return false;
    } finally {
      dismissDialog();
    }
  }
}
