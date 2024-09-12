import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import '../../data/constants/color_constant.dart';

class BackgroundCommon extends StatelessWidget {
  const BackgroundCommon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: Get.height * 0.3,
            width: Get.height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(250, 250),
                ),
                color: ColorConstant.primaryColor.withOpacity(0.4)),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                height: Get.height * 0.3,
                width: Get.height * 0.3,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: Get.height * 0.2,
            width: Get.height * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(250, 250),
                ),
                color: ColorConstant.primaryColor.withOpacity(0.4)),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                height: Get.height * 0.3,
                width: Get.height * 0.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
