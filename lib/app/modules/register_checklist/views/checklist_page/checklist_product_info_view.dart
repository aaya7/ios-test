import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/register_checklist_header_widget.dart';
import 'package:hero/app/core/widgets/shimmer/shimmerlistview.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_license_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_product_info_controller.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_add_license_view.dart';

import '../../../../core/widgets/common_dropdown_widget.dart';
import '../../../../data/constants/color_constant.dart';

class ChecklistProductInfoView extends GetView<ChecklistProductInfoController> {
  const ChecklistProductInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Product Information"),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
            RegisterChecklistHeaderWidget(
                icon: FontAwesomeIcons.briefcase,
                title: controller.productRole?.name ?? '',
                subtitle:
                    "Please complete required information below to do your applied job"),
            30.0.height,
            Expanded(
              child: ListView.builder(
                  itemCount: controller.productRole?.productRoles?.length ?? 0,
                  // shrinkWrap: true,
                  primary: true,
                  itemBuilder: (context, index1) {
                    final mainItem =
                        controller.productRole?.productRoles?.elementAt(index1);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mainItem?.productRoleName ?? '',
                          style: context.textTheme.headline3!,
                        ),
                        10.0.height,
                        ListView.builder(
                            itemCount: mainItem?.requirements?.length ?? 0,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              final item =
                                  mainItem?.requirements?.elementAt(index);
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        controller
                                            .getIcon(item?.requirement ?? ''),
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                      20.0.width,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            controller.getTitle(
                                                item?.requirement ?? ''),
                                            style: context.textTheme.headline3!,
                                          ),
                                          5.0.height,
                                          Text(
                                            "* Required: ${(item?.name ?? '-')}",
                                            style: context.textTheme.headline6!
                                                .copyWith(color: Colors.orange),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      (item?.checklistStatus ?? false)
                                          ? Text(
                                              "Done",
                                              style: context
                                                  .textTheme.headline6!
                                                  .copyWith(
                                                      color: ColorConstant
                                                          .primaryColor),
                                            )
                                          : const Icon(
                                              FontAwesomeIcons.chevronRight,
                                              color: Colors.grey,
                                              size: 14,
                                            )
                                    ],
                                  ).paddingSymmetric(vertical: 10).onTap(() {
                                    if(!(item?.checklistStatus ?? false)){
                                      controller.routeToChecklist(
                                          item?.requirement ?? '');
                                    }

                                  }),
                                  Divider(
                                    color: Colors.grey[300],
                                    thickness: 0.5,
                                  )
                                ],
                              ).onTap(() async {});
                            }),
                        30.0.height,
                      ],
                    );
                  }),
            ),
            10.0.height,
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
      // bottomNavigationBar: Container(
      //   width: width,
      //   padding: EdgeInsets.all(15),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.5),
      //         spreadRadius: 5,
      //         blurRadius: 7,
      //         offset: const Offset(0, 3),
      //       ),
      //     ],
      //   ),
      //   child: CommonButton(title: "Continue", callBack: () {}),
      // ),
    );
  }
}
