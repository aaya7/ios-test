import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_no_data_error.dart';
import 'package:hero/app/core/widgets/shimmer/shimmerlistview.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/routes/app_pages.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/widgets/comming_soon_widget.dart';
import '../../../core/widgets/common_tabbar_widget.dart';
import '../controllers/messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (MediaQuery.of(context).padding.top).height,
            10.0.height,
            Text(
              "Messages".tr,
              style: context.textTheme.headline2!,
            ),
            20.0.height,
            // CommonTabBarWidget(
            //     tabController: controller.tabController,
            //     isEnabled: false,
            //     tabBarList:  [
            //       Tab(
            //         text: "Chats".tr,
            //       ),
            //       Tab(
            //         text: "Notification".tr,
            //       ),
            //     ]).paddingSymmetric(horizontal: width * 0.04),
            20.0.height,
            // const Expanded(
            //   child: ComingSoonWidget(
            //     child: SizedBox.shrink(),
            //   ),
            // ),
            Expanded(
              child: Obx(() {
                return controller.isNotificationLoading.isTrue
                    ? const ShimmerListView()
                    : controller.notificationList.isEmpty
                        ? const NoNotificationScreen()
                        : ListView.builder(
                            itemCount: controller.notificationList.length,
                            padding: const EdgeInsets.only(top: 0),
                            itemBuilder: (_, index) {
                              final item =
                                  controller.notificationList.elementAt(index);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: ColorConstant
                                                .primaryLightColor
                                                .withOpacity(0.5),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color:
                                                    ColorConstant.primaryColor,
                                                width: 0.5),
                                          ),
                                          child: const Icon(
                                            LineIcons.bullhorn,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              item.title ?? '',
                                              style:
                                                  context.textTheme.headline3!,
                                            ),
                                            Text(
                                              item.body ?? '',
                                              style: context
                                                  .textTheme.headline6!
                                                  .copyWith(color: Colors.grey),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ).paddingOnly(left: 5.0),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              timeago.format(
                                                DateTime.parse(
                                                  item.createdAt ??
                                                      DateTime.now().toString(),
                                                ),
                                              ),
                                              style: context
                                                  .textTheme.headline3!
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ).onTap(() {
                                    Get.toNamed(Routes.NOTIFICATION_DETAIL,
                                        arguments: {"uuid": item.uuid});
                                  }),
                                  Divider(
                                    color: Colors.grey[300],
                                    thickness: 0.5,
                                  )
                                ],
                              );
                            },
                          );
              }),
            ),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}

class NoNotificationScreen extends StatelessWidget {
  const NoNotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.0.height,
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: const Icon(
              LineIcons.check,
              color: Colors.green,
              size: 40,
            ),
          ),
          20.0.height,
          Text(
            "All Up To Date".tr,
            style: context.textTheme.headline3!.copyWith(fontSize: 20),
          ),
          10.0.height,
          Text(
            "You’re all caught up! No notifications as of now.".tr,
            textAlign: TextAlign.center,
            style: context.textTheme.headline6!
                .copyWith(color: Colors.grey, fontSize: 16),
          ).paddingSymmetric(horizontal: 50),
        ],
      ),
    );
  }
}
