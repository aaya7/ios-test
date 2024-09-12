import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/constants/color_constant.dart';

class CommonPageIndicator {
  static _indicator(bool isActive) {
    return AnimatedContainer(
      duration: 300.milliseconds,
      height: 10,
      width: isActive ? 30 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: isActive ? ColorConstant.textPrimaryColor : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(5)),
    );
  }

  static List<Widget> buildIndicator({required RxInt currentIndex, required int length}) {
    List<Widget> indicators = [];
    for (int i = 0; i < length; i++) {
      indicators.add(_indicator(currentIndex.value == i));
    }

    return indicators;
  }
}
