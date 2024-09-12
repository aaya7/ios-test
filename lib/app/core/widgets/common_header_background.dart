import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/constants/color_constant.dart';

class HeaderBackground extends StatelessWidget {
  const HeaderBackground({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            width: width,
            decoration: const BoxDecoration(
              color: ColorConstant.primaryColor,
            ),
            child: child),
        Positioned(
          top: -60,
          right: -40,
          child: FadeInRight(
            delay: 400.milliseconds,
            child: Container(
              width: width * 0.85,
              height: width * 0.85,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
            ),
          ),
        ),
        Positioned(
          top: -60,
          right: -40,
          child: FadeInRight(
            delay: 800.milliseconds,
            child: Container(
              width: width * 0.65,
              height: width * 0.65,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
            ),
          ),
        ),
        Positioned(
          top: -60,
          right: -40,
          child: FadeInRight(
            delay: 1200.milliseconds,
            child: Container(
              width: width * 0.45,
              height: width * 0.45,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
            ),
          ),
        )
      ],
    );
  }
}
