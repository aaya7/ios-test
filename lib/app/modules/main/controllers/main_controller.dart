import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/models/auth_models/profile_model.dart';
import 'package:hero/app/modules/home/controllers/home_controller.dart';
import 'package:hero/app/modules/jobs/controllers/jobs_controller.dart';
import 'package:hero/app/modules/messages/controllers/messages_controller.dart';
import 'package:hero/app/modules/profile/controllers/profile_controller.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_dropdown_widget.dart';
import '../../../core/widgets/common_widget.dart';
import '../../../core/widgets/custom_bottom_sheet.dart';
import '../../../data/constants/color_constant.dart';
import '../../../data/constants/constant.dart';
import '../../../data/models/misc_models/dropdown_model.dart';
import '../../../data/repositories/auth_repositories/auth_repository.dart';
import '../../../data/repositories/misc_repositories/misc_repository.dart';

class MainController extends GetxController {
  final contentIndex = 0.obs;

  final stateSelected = Rxn<String>();
  final citySelected = Rxn<DropdownModel>();

  final stateList = <String>[].obs;

  final cityList = <DropdownModel>[].obs;

  final isSaveLocationLoading = false.obs;

  final profileModel = ProfileModel().obs;

  @override
  void onInit() async {
    super.onInit();
    CommonService.firebaseMessageHandler();
    await fetchProfile();

    ever(contentIndex, (callback) async{

      await fetchProfile();

      if(callback == 0){
        Get.find<HomeController>().onInit();
      }else if(callback == 1){
        Get.find<JobsController>().fetchJobs();
        Get.find<JobsController>().fetchAssignedJob();
        Get.find<JobsController>().fetchMerchantList();
        Get.find<JobsController>().fetchProductRole();
      } else if(callback == 2){
        Get.find<MessagesController>().fetchNotificationList();
      }else if(callback == 3){
        Get.find<ProfileController>().onInit();
      }

    });

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
      stateSelected.value = stateList.firstWhereOrNull(
          (element) => element == (profileModel.value.preferredStateLocation));
    } catch (error) {
      snackBarFailed(context: Get.context!, content: "Fail to fetch states");
    }
  }

  Future<void> fetchProfile() async {
    try {
      profileModel(await AuthRepository.instance.getUserProfile());
      await fetchState();
      fetchCities(state: stateSelected.value ?? '');
    } catch (error, st) {
      log("xxx profile $error $st");
    }
  }

  Future<void> fetchCities({required String state}) async {
    try {
      cityList(await MiscRepository.instance.getCities(state: state));
      citySelected.value = cityList.firstWhereOrNull(
              (element) => element.name == (profileModel.value.preferredCityLocation));
    } catch (error) {
      snackBarFailed(context: Get.context!, content: "Fail to fetch cities");
    }
  }

  Future<void> saveLocation() async {
    try {
      isSaveLocationLoading(true);
      dio.Response response = await AuthRepository.instance
          .changePreferWorkingArea(city: citySelected.value?.name ?? '');
      isSaveLocationLoading(false);

      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      dismissBottomSheet();
      fetchProfile();
      Get.find<HomeController>().fetchDashboard();
    } catch (error, st) {
      isSaveLocationLoading(false);
      toastFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
      log("xxx save location $error $st");
    }
  }

  void openUpdateLocationBottomSheet() async {
    stateSelected.value = stateList.firstWhereOrNull(
            (element) => element == (profileModel.value.preferredStateLocation));
    citySelected.value = cityList.firstWhereOrNull(
            (element) => element.name == (profileModel.value.preferredCityLocation));
    await openBottomSheet(children: [
      10.0.height,
      Center(
        child: Text(
          "Choose where your preferred location desire to do job".tr,
          textAlign: TextAlign.center,
          style: Get.context!.textTheme.headline6!.copyWith(color: Colors.grey),
        ),
      ),
      20.0.height,
      Center(
          child: LottieBuilder.asset(
        "assets/lottie/location.json",
        height: 120,
      )),
      20.0.height,
      Text("Preferred Location".tr),
      10.0.height,
      Row(
        children: [
          Expanded(
            child: CommonDropdownWidget(
                selectedValue: stateSelected,
                dropdownList: stateList,
                title: "State".tr,
                hintText: "State".tr,
                onChanged: (_) {
                  stateSelected.value = _;
                  citySelected.value = null;
                  fetchCities(state: _);
                },
                displayItem: ""),
          ),
          10.0.width,
          Expanded(
            child: CommonDropdownWidget(
                selectedValue: citySelected,
                dropdownList: cityList,
                title: "City".tr,
                hintText: "City".tr,
                onChanged: (_) {
                  citySelected.value = _;
                },
                displayItem: "name"),
          ),
        ],
      ),
      20.0.height,
      Obx(() {
        return isSaveLocationLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.primaryColor,
                ),
              )
            : CommonButton(
                title: "Save".tr,
                callBack: () {
                  saveLocation();
                });
      }),
      30.0.height,
    ], title: "Preferred Working Location".tr);
  }
}
