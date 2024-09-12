import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../data/constants/constant.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key, this.text}) : super(key: key);

  final RxString? text;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.back(closeOverlays: true);
        return false;
      },
      // child: LottieBuilder.asset(
      //         'assets/lottie/paperplane2.json',
      //       ),
      child: Align(
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: Get.width * 0.4,
                maxWidth: Get.width * 0.5,
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LottieBuilder.asset(
                      'assets/lottie/loading3.json',
                      fit: BoxFit.cover,
                      height: Get.width * 0.4,
                    ),
                    text != null
                        ? Obx(() {
                            return Text((text ?? "".obs).value)
                                .paddingSymmetric(vertical: 15);
                          })
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
