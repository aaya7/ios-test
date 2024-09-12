import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';

import '../controllers/notification_setting_controller.dart';

class NotificationSettingView extends GetView<NotificationSettingController> {
  const NotificationSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Notifications".tr),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.0.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[400]!)),
                    child: Icon(
                      FontAwesomeIcons.bell,
                      color: Colors.black54,
                      size: 18,
                    ),
                  ),
                  20.0.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notifications".tr,
                          style:
                              context.textTheme.headline3!.copyWith(fontSize: 20),
                        ),
                        Text(
                          "Adjust notifications here".tr,
                          style:
                              context.textTheme.headline6!.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              50.0.height,
              Text(
                "Notify Me When".tr,
                style: context.textTheme.headline3,
              ),
              10.0.height,
              NotificationSwitchCard(
                  title: "Incoming New Message".tr,
                  onCheck: controller.incomingNewMessage),
              NotificationSwitchCard(
                  title: "New Job Alert".tr,
                  onCheck: controller.newJobAlert),
              NotificationSwitchCard(
                  title: "Jobs For Me".tr,
                  onCheck: controller.jobsForMe),
              20.0.height,
              // CommonTextField(hintText: "Device Token", textEditingController: controller.fcmTokenTextController, title: "Device Token", maxLines: 4, minLines: 3,)
            ],
          ).paddingSymmetric(horizontal: width * 0.04),
        ),
      ),
    );
  }
}

class NotificationSwitchCard extends StatelessWidget {
  const NotificationSwitchCard({
    super.key,
    this.subtitle,
    required this.title,
    required this.onCheck,
  });

  final String title;
  final String? subtitle;
  final RxBool onCheck;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: context.textTheme.headline5!
                      .copyWith(color: Colors.black54),
                ),
                const Spacer(),
                Obx(() {
                  return CupertinoSwitch(
                      value: onCheck.value,
                      onChanged: (_) {
                        onCheck.value = _;
                      });
                })
              ],
            ),
            subtitle != null
                ? Text(
                    subtitle ?? '',
                    style: context.textTheme.headline6!.copyWith(),
                  ).paddingOnly(top: 10)
                : const SizedBox.shrink(),
            10.0.height,
          ],
        ),
        const Divider(
          thickness: 0.2,
          color: Colors.grey,
        ),
        10.0.height,
      ],
    );
  }
}
