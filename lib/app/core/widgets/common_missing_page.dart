import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/constants/extensions/double_extension.dart';

class CommonMissingPageScreen extends StatelessWidget {
  const CommonMissingPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/not_found_recycliot.png', width: Get.width * 0.4,),
              (Get.width * 0.05).height,
              Text('Content Not Found', style: context.textTheme.headline3,)
            ],
          ),
        ),
    );
  }
}
