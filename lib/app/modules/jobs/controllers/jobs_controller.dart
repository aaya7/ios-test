import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/models/jobs_models/assigned_job_list_model.dart';
import 'package:hero/app/data/models/jobs_models/browse_job_list_model.dart';
import 'package:hero/app/data/models/misc_models/dropdown_model.dart';
import 'package:hero/app/data/models/misc_models/product_role_model.dart';
import 'package:hero/app/data/repositories/job_repositories/job_repository.dart';
import 'package:hero/app/data/repositories/misc_repositories/misc_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class JobsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  // final jobNearbyList = <DummyJobs>[].obs;

  final isNearbyJobLoading = false.obs;

  final filterChipList = <String>["Filter"].obs;

  final assignedFilterChipList = <String>["Overview", "Ongoing", "Done"].obs;

  final filterSelected = "".obs;

  final assignedFilterSelected = "".obs;

  final sortSelected = "".obs;

  final isSortFullTime = false.obs;
  final isSortPartTime = false.obs;

  final filterRoleList = <DropdownModel>[].obs;

  final filterRoleListSelected = <DropdownModel>[].obs;

  final productRoleModel = ProductRoleModel().obs;

  final selectedProductRoleList = <ProductRole>[].obs;

  final filterMerchantList = <DropdownModel>[].obs;

  final filterMerchantListSelected = <DropdownModel>[].obs;

  final refreshController = RefreshController();
  final refreshController2 = RefreshController();

  final jobList = RxList<BrowseJobListModel>();
  final assignedJobList = RxList<AssignedJobListModel>();

  final isLoading = false.obs;
  final isAssignLoading = false.obs;

  final availableStates = <String>[].obs;
  final availableStatesSelected = Rxn<String>();
  final availableCities = <String>[].obs;
  final availableCitiesSelected = Rxn<String>();

  int page = 1;

  bool isFiltered = false;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    fetchJobs();
    fetchAssignedJob();
    fetchMerchantList();
    fetchProductRole();
    fetchProductRole2();
    fetchAvailableLocationState();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchJobs() async {
    try {
      isLoading(true);
      page = 1;

      List<String>? merchants;
      List<String>? productRoles;
      List<String>? location;

      if(availableCitiesSelected.value != null){
        location = <String>[];
        location.add(availableCitiesSelected.value ?? '');
      }

      if (filterMerchantListSelected.isNotEmpty) {
        merchants = <String>[];
        for (var merchant in filterMerchantListSelected) {
          merchants.add(merchant.code ?? '');
        }
      }

      if (selectedProductRoleList.isNotEmpty) {
        productRoles = <String>[];
        for (var merchant in selectedProductRoleList) {
          productRoles.add(merchant.uuid ?? '');
        }
      }

      List<String> jobTypes = [];
      if (isSortFullTime.isTrue) {
        jobTypes.add("1");
      } else {
        jobTypes.removeWhere((element) => element == "1");
      }

      if (isSortPartTime.isTrue) {
        jobTypes.add("0");
      } else {
        jobTypes.removeWhere((element) => element == "0");
      }

      jobList(await JobRepository.instance.getBrowseJob(
          page: page.toString(),
          merchantCodes: merchants,
          productRoleUUIDs: productRoles,
          locations: location,
          jobTypes: jobTypes));
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
      assignedJobList(await JobRepository.instance.getAssignedJobs());
    } catch (error, st) {
      log("xxxx fetch $error $st");
      snackBarFailed(
          context: Get.context!,
          content: "Failed to get jobs list. Please try again later");
    } finally {
      isAssignLoading(false);
    }
  }

  Future<void> fetchNextPageJobs() async {
    try {
      page = page + 1;
      List<String>? merchants;
      List<String>? productRoles;

      if (filterMerchantListSelected.isNotEmpty) {
        merchants = <String>[];
        for (var merchant in filterMerchantListSelected) {
          merchants.add(merchant.code ?? '');
        }
      }

      if (filterRoleListSelected.isNotEmpty) {
        merchants = <String>[];
        for (var merchant in filterRoleListSelected) {
          merchants.add(merchant.uuid ?? '');
        }
      }

      List<String> jobTypes = [];
      if (isSortFullTime.isTrue) {
        jobTypes.add("1");
      } else {
        jobTypes.removeWhere((element) => element == "1");
      }

      if (isSortPartTime.isTrue) {
        jobTypes.add("0");
      } else {
        jobTypes.removeWhere((element) => element == "0");
      }

      jobList.addAll(await JobRepository.instance.getBrowseJob(
          page: page.toString(),
          merchantCodes: merchants,
          productRoleUUIDs: productRoles,
          jobTypes: jobTypes));
    } catch (error, st) {
      log("xxxx fetch $error $st");
      snackBarFailed(
          context: Get.context!,
          content: "Failed to get jobs list. Please try again later");
    }
  }

  Future<void> fetchProductRole() async {
    try {
      filterRoleList(await MiscRepository.instance.getProductRoleListing());
    } catch (error, st) {
      log("xxxx $error $st");
    }
  }

  Future<void> fetchProductRole2() async {
    try {
      productRoleModel(await MiscRepository.instance.getProductRoleList());
    } catch (error, st) {
      log("xxxx $error $st");
    }
  }

  Future<void> fetchMerchantList() async {
    try {
      filterMerchantList(await MiscRepository.instance.getMerchantList());
    } catch (error, st) {
      log("xxxx $error $st");
    }
  }

  Future<void> fetchAvailableLocationState() async {
    try {
      availableStates(
          await MiscRepository.instance.getAvailableLocationStates());
      log("xxxx availableState ${jsonEncode(availableStates)}");
    } catch (error, st) {
      log("xxxx $error $st");
    }
  }

  Future<void> fetchAvailableLocationCities({required String state}) async {
    try {
      availableCities(await MiscRepository.instance
          .getAvailableLocationCities(state: state));
    } catch (error, st) {
      log("xxxx $error $st");
    }
  }

  void clearFilter() {
    isSortFullTime.value = false;
    isSortPartTime.value = false;

    filterMerchantListSelected.clear();
    filterRoleListSelected.clear();

    availableStatesSelected.value = null;
    availableCitiesSelected.value = null;
    availableCities.clear();

    fetchJobs();
  }
}
