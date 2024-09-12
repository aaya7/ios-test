import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/data/constants/extensions/datetime_extensions.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:line_icons/line_icons.dart';

import '../../../data/constants/color_constant.dart';
import '../controllers/notification_detail_controller.dart';

class NotificationDetailView extends GetView<NotificationDetailController> {
  const NotificationDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Notification Detail"),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.primaryColor,
                ),
              )
            : SizedBox(
                width: width,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: ColorConstant.primaryLightColor
                                  .withOpacity(0.5),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: ColorConstant.primaryColor,
                                  width: 0.5),
                            ),
                            child: const Icon(
                              LineIcons.bullhorn,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.notificationDetail.value.title ?? '',
                                style: context.textTheme.headline3!
                                    .copyWith(fontSize: 22),
                              ),
                              10.0.height,
                              Text(
                                controller.parseDateTime(controller
                                    .notificationDetail.value.createdAt),
                                style: context.textTheme.headline3!
                                    .copyWith(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ).paddingOnly(left: 5.0),
                        ),
                      ],
                    ),
                    10.0.height,
                    Divider(
                      color: Colors.grey[300],
                      thickness: 0.5,
                    ),
                    10.0.height,
                    Text(
                      controller.notificationDetail.value.body ?? '',
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.black54, fontSize: 17),
                    )
                  ],
                ).paddingSymmetric(horizontal: width * 0.04),
              );
      }),
    );
  }
}
