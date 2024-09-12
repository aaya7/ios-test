import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_personal_info_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_product_info_status_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/personal_info_update_param_model.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_vehicle_info_view.dart';
import '../../../core/widgets/common_widget.dart';
import '../../../data/models/misc_models/dropdown_model.dart';
import '../../../data/repositories/misc_repositories/misc_repository.dart';
import '../../../routes/app_pages.dart';
import '../views/checklist_page/checklist_license_info_view.dart';

class ChecklistProductInfoController extends GetxController {


  Product? productRole;


  @override
  void onInit() async{
    super.onInit();

    if(Get.arguments != null){
      if(Get.arguments["item"] != null){
        productRole = Get.arguments["item"];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
        Get.toNamed(Routes.ONBOARDING);
    }

  }

  IconData getIcon(String item){

    if(item.contains("personal")){
     return FontAwesomeIcons.idCard;
    }

    if(item.contains("license")){
      return FontAwesomeIcons.idBadge;
    }

    if(item.contains("bank")){
      return FontAwesomeIcons.bank;
    }

    if(item.contains("emergency")){
      return FontAwesomeIcons.phone;
    }

    if(item.contains("transportation")){
      return FontAwesomeIcons.carSide;
    }


    return FontAwesomeIcons.idCardClip;
  }

  String getTitle(String item){

    if(item.contains("personal")){
      return "Personal Information";
    }

    if(item.contains("license")){
      return "License Information";
    }

    if(item.contains("bank")){
      return "Bank Information";
    }

    if(item.contains("emergency")){
      return "Emergency Contact Information";
    }

    if(item.contains("transportation")){
      return "Transportation Information";
    }


    return "-";
  }

}
