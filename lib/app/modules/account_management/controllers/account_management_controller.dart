import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AccountManagementController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  final parcelList = [
    DummyParcelStatisticModel(
        merchantName: "Shopee Express",
        merchantLogo:
            "https://posttrack.com/cdn/images/carriers/icons/0281-shopee-express-my.png",
        count: 130),
    DummyParcelStatisticModel(
        merchantName: "NinjaVan",
        merchantLogo:
            "https://blog.ninjavan.co/wp-content/uploads/sites/3/2021/12/Display-Pic-01.png",
        count: 80),
    DummyParcelStatisticModel(
        merchantName: "Lazada",
        merchantLogo:
            "https://images.crunchbase.com/image/upload/c_lpad,f_auto,q_auto:eco,dpr_1/u5wuznqdbzwnv0bulka9",
        count: 52),
    DummyParcelStatisticModel(
        merchantName: "Flash Express",
        merchantLogo: "https://mytrackcdn.com/images/couriers/flash.jpg.webp",
        count: 15),
  ].obs;

  final int dataPoints = 7;

  List<FlSpot> generateRandomDataPoints() {
    final random = Random();
    final List<FlSpot> data = List.generate(dataPoints, (index) {
      final x = index.toDouble();
      final y = random.nextDouble() * 4.0; // Adjust the range as needed
      return FlSpot(x, y);
    });
    return data;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String getCurrentMonthYear() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM y');
    final formattedDate = formatter.format(now);
    return formattedDate.toUpperCase();
  }
}

class DummyParcelStatisticModel {
  final String merchantName;
  final String merchantLogo;
  final double count;

  DummyParcelStatisticModel(
      {required this.merchantName,
      required this.merchantLogo,
      required this.count});
}
