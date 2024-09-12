import 'package:flutter/material.dart';
import '../../data/constants/extensions/double_extension.dart';
import 'package:get/get.dart';

import '../../data/constants/color_constant.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    Key? key,
    required this.title,
    required this.info,
    required this.confirmText,
    this.cancelText,
    this.cancelCallback,
    this.confirmCallback,
    this.confirmButtonColor,
    this.cancelButtonColor,
    this.icon,
    this.confirmIcon,
    this.cancelIcon, this.additionalWidget,
  }) : super(key: key);

  final String title;
  final String info;
  final String confirmText;
  final String? cancelText;
  final VoidCallback? cancelCallback;
  final VoidCallback? confirmCallback;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;
  final Widget? icon;
  final IconData? confirmIcon;
  final IconData? cancelIcon;
  final Widget? additionalWidget;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: Get.width * 0.8,
              maxWidth: Get.width * 0.83,
            ),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon != null ? (Get.width * 0.04).height : Container(),
                  Center(child: icon ?? Container()),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: context.textTheme.headline2!.copyWith(fontSize: 20)),
                        const SizedBox(height: 10),
                        Text(info,
                            style: context.textTheme.headline6!.copyWith(color: Colors.black54, fontSize: 16)),
                      ],
                    ),
                  ),
                  additionalWidget ?? const SizedBox.shrink(),
                  // Spacer(),
                  Center(
                    child: Container(
                      width: Get.width * 0.7,
                      margin: EdgeInsets.only(bottom: Get.width * 0.04),
                      child: ElevatedButton(
                        onPressed: confirmCallback ??
                            () {
                              if (Get.isDialogOpen!) {
                                Get.back();
                              }
                            },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                confirmButtonColor ??
                                    ColorConstant.primaryColor)),
                        child: SizedBox(
                          height: Get.height * 0.07,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                confirmIcon != null
                                    ? Icon(
                                        confirmIcon,
                                        color: Colors.white,
                                      ).marginOnly(right: Get.width * 0.03)
                                    : Container(),
                                Text(
                                  confirmText,
                                  style: context.textTheme.headline6!.copyWith(
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  cancelText == null
                      ? Container()
                      : Center(
                          child: Container(
                            width: Get.width * 0.7,
                            margin: EdgeInsets.only(bottom: Get.width * 0.04),
                            child: ElevatedButton(
                              onPressed: cancelCallback ??
                                      () {
                                    if (Get.isDialogOpen!) {
                                      Get.back();
                                    }
                                  },
                              child: Container(
                                height: Get.height * 0.07,
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      cancelIcon != null
                                          ? Icon(
                                              cancelIcon,
                                              color: Colors.white,
                                            ).marginOnly(
                                              right: Get.width * 0.03)
                                          : Container(),
                                      Text(
                                        cancelText!,
                                        style: context.textTheme.headline6!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          cancelButtonColor ?? Colors.grey)),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
