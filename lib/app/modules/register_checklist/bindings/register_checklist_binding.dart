import 'package:get/get.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_bank_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_emergency_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_license_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_product_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_vehicle_info_controller.dart';

import '../controllers/checklist_personal_info_controller.dart';
import '../controllers/register_checklist_controller.dart';

class RegisterChecklistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterChecklistController>(
      () => RegisterChecklistController(),
    );

    Get.lazyPut<ChecklistPersonalInfoController>(
        () => ChecklistPersonalInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistBankInfoController>(
        () => ChecklistBankInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistEmergencyInfoController>(
        () => ChecklistEmergencyInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistLicenseInfoController>(
        () => ChecklistLicenseInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistVehicleInfoController>(
            () => ChecklistVehicleInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistProductInfoController>(
            () => ChecklistProductInfoController(),
        fenix: true);
  }
}
