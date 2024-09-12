import 'dart:developer';

import 'package:get/get.dart';

class WorkPreferenceController extends GetxController {
  final serviceList = [
    "Free Mile Delivery",
    "Last Mile Delivery",
  ].obs;

  final serviceSelected = Rxn<String>();

  final workingTimeList = [
    "Part-Time",
    "Full-Time",
  ].obs;

  final workingTimeSelected = Rxn<String>();

  final workDayPrefList = [
    "Weekday Only",
    "Weekend Only",
    "Everyday",
  ].obs;

  final workDayPrefSelected = Rxn<String>();

  final phoneTypeList = ["Android", "iOS (iPhone)"].obs;

  final phoneTypeSelected = Rxn<String>();

  final vehicleList = [
    "Car",
    "Van",
    "Motorcycle",
    "Lorry",
  ].obs;

  final vehicleSelected = Rxn<String>();

  final vehicleType = [
    "Sedan",
    "SUV",
  ].obs;

  final vehicleTypeSelected = Rxn<String>();

  final licenseTypeList = [
    "D Type",
    "B Type",
    "B2 Type",
    "GDL Type",
  ].obs;

  final licenseTypeSelected = Rxn<String>();

  final vehicleModelList = [
    "Proton",
    "Perodua",
    "Daihatsu",
    "BMW",
  ].obs;

  final vehicleModelSelected = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
