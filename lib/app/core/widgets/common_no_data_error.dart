import 'package:flutter/material.dart';
import '../../data/constants/extensions/double_extension.dart';
import 'package:get/get.dart';


class CommonNoDataErrorWidget extends StatelessWidget {
  const CommonNoDataErrorWidget({
    super.key, this.content,
  });

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/Empty_Box.png",
            width: Get.width * 0.4,
          ),
          20.0.height,
          Text(
            "OOPSS!",
            style: context.textTheme.headline3!.copyWith(),
          ),
          10.0.height,
          Text(
            content ?? "Not available yet, stay tuned for more updates",
            textAlign: TextAlign.center,
            style: context.textTheme.headline6!.copyWith(color: Colors.grey),
          ).paddingSymmetric(horizontal: 40),
        ],
      ),
    );
  }
}
