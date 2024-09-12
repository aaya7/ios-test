import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:hero/app/modules/register_checklist/controllers/checklist_vehicle_info_controller.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_add_vehicle_info_view.dart';

import '../../../../core/widgets/common_dropdown_widget.dart';
import '../../../../data/constants/color_constant.dart';

class ChecklistVehicleInfoView extends GetView<ChecklistVehicleInfoController> {
  const ChecklistVehicleInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Vehicle Information".tr),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
            RegisterChecklistHeaderWidget(
                icon: FontAwesomeIcons.carSide,
                title: "Vehicle Information".tr,
                subtitle:
                    "We need your vehicle information. Please add at least one vehicle".tr),
            30.0.height,
            Expanded(
              child: Obx(() {
                return controller.isLoading.isTrue
                    ? const ShimmerListView()
                    : (controller.vehicleInfoModel.value.transportations ?? [])
                            .isEmpty
                        ? const NoVehicleDataWidget()
                        : ListView.builder(
                            itemCount: (controller.vehicleInfoModel.value
                                        .transportations ??
                                    [])
                                .length,
                            itemBuilder: (_, index) {
                              final item = controller
                                  .vehicleInfoModel.value.transportations
                                  ?.elementAt(index);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [

                                      Expanded(
                                        flex: 9,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${item?.plateNumber ?? ''} (${(item?.transportationType ?? '')
                                                  .capitalizeFirst ??
                                                  ''})",
                                              style:
                                                  context.textTheme.headline3,
                                            ),
                                            10.0.height,
                                            Text(
                                              "${'Road Tax Expired Date'.tr}: ${(item?.roadTaxExpiryDate) ?? ''}",
                                              style: context
                                                  .textTheme.headline6!
                                                  .copyWith(color: Colors.grey),
                                            ),
                                          ],
                                        ).paddingSymmetric(horizontal: 10),
                                      ),
                                      const Expanded(
                                          flex: 1,
                                          child: Icon(
                                            FontAwesomeIcons.chevronRight,
                                            color: Colors.grey,
                                            size: 18,
                                          ))
                                    ],
                                  ),
                                  Divider(color: Colors.grey[300], thickness: 0.5, )
                                ],
                              ).onTap((){
                                Get.to(ChecklistAddVehicleInfoView(item: item,));
                              }).marginOnly(bottom: 10);
                            });
              }),
            ),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
      bottomNavigationBar: Container(
        width: width,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CommonButton(
            title: "Add Vehicle".tr,
            callBack: () async {
              await Get.to(const ChecklistAddVehicleInfoView());
              controller.clearAllField();
            }),
      ),
    );
  }
}

class NoVehicleDataWidget extends StatelessWidget {
  const NoVehicleDataWidget({
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
              FontAwesomeIcons.car,
              color: Colors.grey,
              size: 40,
            ),
          ),
          20.0.height,
          Text(
            "Add Vehicle Information".tr,
            style: context.textTheme.headline3!.copyWith(fontSize: 20),
          ),
          10.0.height,
          Text(
            "Looks like there are no vehicle information yet. Please add one".tr,
            textAlign: TextAlign.center,
            style: context.textTheme.headline6!.copyWith(color: Colors.grey),
          ).paddingSymmetric(horizontal: 20),
        ],
      ),
    );
  }
}
