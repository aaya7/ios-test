import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_bank_info_model.dart';
import 'package:hero/app/data/models/misc_models/dropdown_model.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';
import 'package:hero/app/data/repositories/misc_repositories/misc_repository.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';

import '../../../data/constants/constant.dart';

class ChecklistBankInfoController extends GetxController {
  final bankList = <DropdownModel>[].obs;
  final bankSelected = Rxn<DropdownModel>();

  final bankInfoModel = BankInfoStatusModel().obs;

  final formKey = GlobalKey<FormState>();

  final bankStatementImage = Rxn<File>();

  final accountHolderNameTextController = TextEditingController();
  final accountNumberTextController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await fetchBankNameList();
    fetchBankInfoStatus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchBankInfoStatus() async {
    try {
      bankInfoModel(await RegisterChecklistRepository.instance.getBankStatus());

      bankSelected(bankList.firstWhereOrNull(
          (element) => element.code == bankInfoModel.value.bankName));

      accountNumberTextController.text =
          bankInfoModel.value.bankAccountNo ?? '';
      accountHolderNameTextController.text =
          bankInfoModel.value.bankAccountHolderName ?? '';
    } catch (error, st) {
      log("xxx $error $st");
    }
  }

  Future<void> fetchBankNameList() async {
    try {
      bankList(await MiscRepository.instance.getBankNameList());
    } catch (error, st) {
      log("xxx $error $st");
    }
  }

  Future<bool> deleteBankStatement() async {
    try {
      showLoading();
      dio.Response response = await RegisterChecklistRepository.instance
          .bankInfoRemoveBankStatement();

      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      return true;
    } catch (error, st) {
      log("xxx delete bank statement $error", stackTrace: st);
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

  Future<void> submitBankInfo() async {
    try {
      if (bankStatementImage.value == null && bankInfoModel.value.bankStatementUrl == null) {
        showRequiredDocImageDialog();
        return;
      }

      showLoading();
      dio.Response response = await RegisterChecklistRepository.instance
          .bankInfoUpdate(
              bankName: bankSelected.value?.code ?? '',
              bankAccountNo: accountNumberTextController.text,
              accountHolderName: accountHolderNameTextController.text,
              bankStatement: bankStatementImage.value);

      dismissDialog();

      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      Get.find<RegisterChecklistController>().fetchChecklistStatus();

      Get.back();
    } catch (error, st) {
      dismissDialog();
      log("xxxx submit bank $error $st");
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }
}
