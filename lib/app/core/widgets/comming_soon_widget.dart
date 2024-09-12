import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';

import '../../data/constants/color_constant.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Stack(
      children: [
        child,
        Container(
          width: width,
          height: Get.height,
          color: Colors.white.withOpacity(0.9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/construction_illustration.png",
                height: 200,
              ),
              20.0.height,
              Text(
                "Will Be Availble Soon..",
                style: context.textTheme.headline3!
                    .copyWith(color: ColorConstant.primaryColor),
              )
            ],
          ),
        )
      ],
    );
  }
}
