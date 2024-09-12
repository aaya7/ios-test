import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hero/app/data/models/auth_models/registration_checklist_status_model.dart';
import 'package:hero/app/data/repositories/auth_repositories/auth_repository.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';
import 'package:hero/app/modules/main/controllers/main_controller.dart';

import '../../../data/models/auth_models/checklist_personal_info_models/checklist_product_info_status_model.dart';
import '../../home/controllers/home_controller.dart';

class RegisterChecklistController extends GetxController {

  final isLoading = false.obs;
  final checklistStatusModel = RegistrationChecklistStatusModel().obs;
  final productChecklistModel = ProductInfoStatusModel().obs;
  final checklistIncompleteCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChecklistStatus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchChecklistStatus() async{
    try{
      isLoading(true);

      try{
        checklistStatusModel(await AuthRepository.instance.checklistStatus());
        checklistIncompleteCount.value = checklistStatusModel.value.incompleteChecklistCount ?? 0;
      }catch(error){

      }

      productChecklistModel(await RegisterChecklistRepository.instance.getProductInfoStatusModel());



      Get.find<HomeController>().fetchChecklistStatus();
      Get.find<MainController>().fetchProfile();
    }catch(error, st){
      log("xxxx fetch checklist $error $st");
    }finally{
      isLoading(false);
    }
  }

}
