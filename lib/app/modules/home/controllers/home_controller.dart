import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_bank_info_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_emergency_info_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_personal_info_view.dart';

import '../../../core/widgets/common_widget.dart';
import '../../../data/models/auth_models/checklist_personal_info_models/checklist_product_info_status_model.dart';
import '../../../data/models/auth_models/registration_checklist_status_model.dart';
import '../../../data/models/jobs_models/assigned_job_list_model.dart';
import '../../../data/models/jobs_models/browse_job_list_model.dart';
import '../../../data/repositories/auth_repositories/auth_repository.dart';
import '../../../data/repositories/job_repositories/job_repository.dart';
import '../../register_checklist/views/checklist_page/checklist_license_info_view.dart';
import '../../register_checklist/views/checklist_page/checklist_vehicle_info_view.dart';

class HomeController extends GetxController {
  // final jobNearbyList = <DummyJobs>[].obs;

  final isNearbyJobLoading = false.obs;

  final visibleItemCount = 5;

  final checklistStatusModel = RegistrationChecklistStatusModel().obs;
  final productChecklistModel = ProductInfoStatusModel().obs;

  final isChecklistLoading = false.obs;

  final checklistIncompleteCount = 0.obs;

  final jobNearbyList = RxList<BrowseJobListModel>();
  final assignedJobList = RxList<AssignedJobListModel>();

  final isLoading = false.obs;
  final isAssignLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
    AuthRepository.instance.lastLoginUpdate();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchDashboard() async {
    fetchChecklistStatus();
    fetchJobs();
    fetchAssignedJob();
  }

  void routeToChecklist(ChecklistType type) {
    switch (type) {
      case ChecklistType.license:
        Get.to(ChecklistLicenseInfoView());
        break;
      case ChecklistType.bank:
        Get.to(ChecklistBankInfoView());
        break;
      case ChecklistType.emergencyContact:
        Get.to(ChecklistEmergencyInfoView());
        break;
      case ChecklistType.transportation:
        Get.to(ChecklistVehicleInfoView());
        break;
      case ChecklistType.personal:
        Get.to(ChecklistPersonalInfoView());
        break;
    }
  }

  Future<void> fetchJobs() async {
    try {
      isLoading(true);
      jobNearbyList(await JobRepository.instance.getDashboardBrowseJob());
    } catch (error, st) {
      log("xxxx fetch $error $st");
      snackBarFailed(
          context: Get.context!,
          content: "Failed to get jobs list. Please try again later");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAssignedJob() async {
    try {
      isAssignLoading(true);
      assignedJobList(await JobRepository.instance.getDashboardAssignedJob());
    } catch (error, st) {
      log("xxxx fetch $error $st");
      snackBarFailed(
          context: Get.context!,
          content: "Failed to get jobs list. Please try again later");
    } finally {
      isAssignLoading(false);
    }
  }

  Future<void> fetchChecklistStatus() async {
    try {
      isChecklistLoading(true);

      checklistStatusModel(await AuthRepository.instance.checklistStatus());

      checklistIncompleteCount.value =
          checklistStatusModel.value.incompleteChecklistCount ?? 0;
    } catch (error, st) {
      log("xxxx fetch checklist $error $st");
    } finally {
      isChecklistLoading(false);
    }
  }

// Future<void> fetchJobNearby() async {
//   try {
//     isNearbyJobLoading(true);
//     Future.delayed(2.seconds);
//     jobNearbyList.addAll([
//       DummyJobs(
//         jobType: "FULL-TIME",
//         jobCategory: "Parcel Sorter",
//         courierName: "NINJAVAN AMPANG",
//         location: "AMPANG",
//         courierImage:
//             "https://blog.ninjavan.co/wp-content/uploads/sites/3/2021/12/Display-Pic-01.png",
//       ),
//       DummyJobs(
//         jobType: "PART-TIME",
//         jobCategory: "Parcel Courier",
//         courierName: "SHOPEE XPRESS AMPANG",
//         location: "AMPANG",
//         courierImage:
//             "https://posttrack.com/cdn/images/carriers/icons/0281-shopee-express-my.png",
//       ),
//       DummyJobs(
//         jobType: "FULL-TIME",
//         jobCategory: "Parcel Sorter",
//         courierName: "NINJAVAN AMPANG",
//         location: "AMPANG",
//         courierImage:
//             "https://blog.ninjavan.co/wp-content/uploads/sites/3/2021/12/Display-Pic-01.png",
//       ),
//       DummyJobs(
//         jobType: "FULL-TIME",
//         jobCategory: "Parcel Sorter",
//         courierName: "LAZADA AMPANG",
//         location: "AMPANG",
//         courierImage:
//             "https://images.crunchbase.com/image/upload/c_lpad,f_auto,q_auto:eco,dpr_1/u5wuznqdbzwnv0bulka9",
//       ),
//       DummyJobs(
//         jobType: "FULL-TIME",
//         jobCategory: "Parcel Sorter",
//         courierName: "FLASH EXPRESS AMPANG",
//         location: "AMPANG",
//         courierImage: "https://mytrackcdn.com/images/couriers/flash.jpg.webp",
//       ),
//       DummyJobs(
//         jobType: "FULL-TIME",
//         jobCategory: "Parcel Sorter",
//         courierName: "NINJAVAN AMPANG",
//         location: "AMPANG",
//         courierImage:
//             "https://blog.ninjavan.co/wp-content/uploads/sites/3/2021/12/Display-Pic-01.png",
//       ),
//       DummyJobs(
//         jobType: "FULL-TIME",
//         jobCategory: "Parcel Sorter",
//         courierName: "NINJAVAN AMPANG",
//         location: "AMPANG",
//         courierImage:
//             "https://blog.ninjavan.co/wp-content/uploads/sites/3/2021/12/Display-Pic-01.png",
//       ),
//     ]);
//   } catch (error, st) {
//     log("xxxx fetch nearby $error $st");
//   } finally {
//     isNearbyJobLoading(false);
//   }
// }
}

class DummyJobs {
  final String jobType;
  final String jobCategory;
  final String courierName;
  final String location;
  final String courierImage;

  DummyJobs(
      {required this.jobType,
      required this.jobCategory,
      required this.courierName,
      required this.location,
      required this.courierImage});
}
