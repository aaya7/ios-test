import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/core/widgets/info_dialog.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_emergency_contact_status_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/emergency_contact_update_param.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';
import 'package:hero/app/data/repositories/misc_repositories/misc_repository.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';

class ChecklistEmergencyInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final secondFormKey = GlobalKey<FormState>();

  final firstContactNameTextController = TextEditingController();
  final firstRelationshipTextController = TextEditingController();
  final firstICTextController = TextEditingController();
  final firstPhoneTextController = TextEditingController();
  final firstAddressTextController = TextEditingController();

  final secondContactNameTextController = TextEditingController();
  final secondRelationshipTextController = TextEditingController();
  final secondICTextController = TextEditingController();
  final secondPhoneTextController = TextEditingController();
  final secondAddressTextController = TextEditingController();

  final emergencyContactInfoModel = EmergencyContactStatusModel().obs;

  final firstFrontIC = Rxn<File>();
  final firstBackIC = Rxn<File>();
  final secondFrontIC = Rxn<File>();
  final secondBackIC = Rxn<File>();

  final relationshipTypeList = <String>[].obs;
  final selectedFirstRelationshipType = Rxn<String>();
  final selectedSecondRelationshipType = Rxn<String>();

  @override
  void onInit() async {
    super.onInit();
    await fetchRelationshipTypeList();
    fetchEmergencyContactStatus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchRelationshipTypeList() async {
    try {
      relationshipTypeList(
          await MiscRepository.instance.getContactRelationshipList());
    } catch (error, st) {
      log('xxxx error fetchRelationshipTypeList $error $st');
    }
  }

  Future<void> submitEmergencyContact() async {
    try {
      // if ((firstFrontIC.value == null &&
      //         emergencyContactInfoModel.value.nextOfKinNameFrontIcUrl ==
      //             null) ||
      //     (firstBackIC.value == null &&
      //         emergencyContactInfoModel.value.nextOfKinNameBackIcUrl == null)) {
      //   showRequiredDocImageDialog();
      //   return;
      // }

      if (firstContactNameTextController.text.isNotEmpty &&
          secondContactNameTextController.text.isNotEmpty) {
        if (formKey.currentState!.validate() &&
            secondFormKey.currentState!.validate()) {
          showLoading();
          EmergencyContactUpdateParam param = EmergencyContactUpdateParam();
          param.nextOfKinName = firstContactNameTextController.text;
          param.nextOfKinNric = firstICTextController.text;
          param.nextOfKinMobile = firstPhoneTextController.text;
          param.nextOfKinAddress = firstAddressTextController.text;
          param.nextOfKinRelationship = firstRelationshipTextController.text;
          param.nextOfKinFrontIcPhoto = firstFrontIC.value;
          param.nextOfKinBackIcPhoto = firstBackIC.value;
          param.secondaryNextOfKinName = secondContactNameTextController.text;
          param.secondaryNextOfKinNric = secondICTextController.text;
          param.secondaryNextOfKinMobile = secondPhoneTextController.text;
          param.secondaryNextOfKinAddress = secondAddressTextController.text;
          param.secondaryNextOfKinRelationship =
              secondRelationshipTextController.text;
          param.secondaryNextOfKinFrontIcPhoto = secondFrontIC.value;
          param.secondaryNextOfKinBackIcPhoto = secondBackIC.value;
          dio.Response response = await RegisterChecklistRepository.instance
              .emergencyContactUpdate(param: param);
          dismissDialog();

          snackBarSuccess(
              context: Get.context!, content: response.data["message"]);

          Get.find<RegisterChecklistController>().fetchChecklistStatus();

          Get.back();
          return;
        }
      }

      if (firstContactNameTextController.text.isNotEmpty) {
        if (formKey.currentState!.validate()) {
          showLoading();
          EmergencyContactUpdateParam param = EmergencyContactUpdateParam();
          param.nextOfKinName = firstContactNameTextController.text;
          param.nextOfKinNric = firstICTextController.text;
          param.nextOfKinMobile = firstPhoneTextController.text;
          param.nextOfKinAddress = firstAddressTextController.text;
          // param.nextOfKinRelationship = firstRelationshipTextController.text;
          param.nextOfKinRelationship = selectedFirstRelationshipType.value;
          param.nextOfKinFrontIcPhoto = firstFrontIC.value;
          param.nextOfKinBackIcPhoto = firstBackIC.value;
          dio.Response response = await RegisterChecklistRepository.instance
              .emergencyContactUpdate(param: param);
          dismissDialog();

          snackBarSuccess(
              context: Get.context!, content: response.data["message"]);

          Get.find<RegisterChecklistController>().fetchChecklistStatus();

          Get.back();
          return;
        }
      }

      if (secondContactNameTextController.text.isNotEmpty) {
        // if ((secondBackIC.value == null &&
        //         emergencyContactInfoModel.value.secondaryNextOfKinFrontIcUrl ==
        //             null) ||
        //     (secondFrontIC.value == null &&
        //         emergencyContactInfoModel.value.secondaryNextOfKinBackIcUrl ==
        //             null)) {
        //   showRequiredDocImageDialog();
        //   return;
        // }
        if (secondFormKey.currentState!.validate()) {
          showLoading();
          EmergencyContactUpdateParam param = EmergencyContactUpdateParam();
          param.secondaryNextOfKinName = secondContactNameTextController.text;
          param.secondaryNextOfKinNric = secondICTextController.text;
          param.secondaryNextOfKinMobile = secondPhoneTextController.text;
          param.secondaryNextOfKinAddress = secondAddressTextController.text;
          param.secondaryNextOfKinRelationship = selectedSecondRelationshipType.value;
          // param.secondaryNextOfKinRelationship =
          //     secondRelationshipTextController.text;
          param.secondaryNextOfKinFrontIcPhoto = secondFrontIC.value;
          param.secondaryNextOfKinBackIcPhoto = secondBackIC.value;
          dio.Response response = await RegisterChecklistRepository.instance
              .emergencyContactUpdate(param: param);
          dismissDialog();

          snackBarSuccess(
              context: Get.context!, content: response.data["message"]);

          Get.find<RegisterChecklistController>().fetchChecklistStatus();

          Get.back();
          return;
        }
      }
    } catch (error, st) {
      dismissDialog();
      log("xxxx submit $error $st");
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }

  Future<void> fetchEmergencyContactStatus() async {
    try {
      // showLoading();
      emergencyContactInfoModel(await RegisterChecklistRepository.instance
          .getEmergencyContactStatus());

      firstContactNameTextController.text =
          emergencyContactInfoModel.value.nextOfKinName ?? '';
      firstRelationshipTextController.text =
          emergencyContactInfoModel.value.nextOfKinRelationship ?? '';
      selectedFirstRelationshipType.value =
          relationshipTypeList.firstWhereOrNull((element) =>
              element ==
              (emergencyContactInfoModel.value.nextOfKinRelationship ?? ''));
      firstICTextController.text =
          emergencyContactInfoModel.value.nextOfKinNric ?? '';
      firstPhoneTextController.text =
          emergencyContactInfoModel.value.nextOfKinMobile ?? '';
      firstAddressTextController.text =
          emergencyContactInfoModel.value.nextOfKinAddress ?? '';
      secondContactNameTextController.text =
          emergencyContactInfoModel.value.secondaryNextOfKinName ?? '';
      secondRelationshipTextController.text =
          emergencyContactInfoModel.value.secondaryNextOfKinRelationship ?? '';
      selectedSecondRelationshipType.value =
          relationshipTypeList.firstWhereOrNull((element) =>
          element ==
              (emergencyContactInfoModel.value.secondaryNextOfKinRelationship ?? ''));
      secondICTextController.text =
          emergencyContactInfoModel.value.secondaryNextOfKinNric ?? '';
      secondPhoneTextController.text =
          emergencyContactInfoModel.value.secondaryNextOfKinMobile ?? '';
      secondAddressTextController.text =
          emergencyContactInfoModel.value.secondaryNextOfKinAddress ?? '';
    } catch (error, st) {
      log("xxx $error $st");
      snackBarFailed(
          context: Get.context!,
          content: "Failed to fetch data! Please try again later");
    } finally {
      // dismissDialog();
    }
  }

  Future<bool> deleteICPPhoto(
      {required bool isFirstContact, required bool isFrontIC}) async {
    try {
      showLoading();
      await RegisterChecklistRepository.instance.emergencyContactRemoveNRIC(
          isFirstContact: isFirstContact, isFront: isFrontIC);

      return true;
    } catch (error, st) {
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
