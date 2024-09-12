import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/comming_soon_widget.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/account_management/controllers/account_management_controller.dart';

import '../../../core/widgets/common_appbar.dart';
import '../../../core/widgets/common_tabbar_widget.dart';

class ViewPerformanceView extends GetView<AccountManagementController> {
  const ViewPerformanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Performance"),
      body: ComingSoonWidget(
        child: SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.0.height,
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[400]!)),
                      child: Icon(
                        FontAwesomeIcons.chartLine,
                        color: Colors.black54,
                        size: 18,
                      ),
                    ),
                    20.0.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Performance",
                          style:
                              context.textTheme.headline3!.copyWith(fontSize: 20),
                        ),
                        Text(
                          "View your job performance.",
                          style:
                              context.textTheme.headline6!.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                20.0.height,
                CommonTabBarWidget(
                    tabController: controller.tabController,
                    tabBarList: const [
                      Tab(
                        text: "Month",
                      ),
                      Tab(
                        text: "Year",
                      ),
                    ]),
                20.0.height,
                Text(
                  controller.getCurrentMonthYear(),
                  style:
                      context.textTheme.headline6!.copyWith(color: Colors.grey),
                ),
                Text(
                  "Earnings Summary",
                  style: context.textTheme.headline3!.copyWith(fontSize: 17),
                ),
                20.0.height,
                SizedBox(
                  height: 150,
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(show: false),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: controller.dataPoints - 1.toDouble(),
                      minY: 0,
                      maxY: 4,
                      lineBarsData: [
                        LineChartBarData(
                          spots: controller.generateRandomDataPoints(),
                          isCurved: true,
                          color: Colors.green,

                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: true,
                            color: ColorConstant.primaryColor,
                            gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [ColorConstant.primaryColor.withOpacity(0.2), Colors.white],
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
                20.0.height,
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TOTAL EARNINGS",
                            style: context.textTheme.headline6!
                                .copyWith(fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            "RM 10,140",
                            style: context.textTheme.headline3!.copyWith(
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NET EARNINGS",
                            style: context.textTheme.headline6!
                                .copyWith(fontSize: 13, color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Text(
                                "+ RM 957.40",
                                style: context.textTheme.headline3!.copyWith(
                                    fontSize: 22,
                                    color: ColorConstant.primaryColor),
                              ),
                              10.0.width,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: ColorConstant.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.arrowUp,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                    5.0.width,
                                    Text(
                                      "23.1 %",
                                      style: context.textTheme.headline6!
                                          .copyWith(
                                              color: Colors.white, fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                10.0.height,
                const Divider(
                  color: Colors.grey,
                  thickness: 0.4,
                ),
                10.0.height,
                Text(
                  "Parcels",
                  style: context.textTheme.headline3!.copyWith(fontSize: 17),
                ),
                10.0.height,
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey[300]!),
                          shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.boxesPacking,
                          color: Colors.black54,
                          size: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TOTAL PARCEL DELIVERED",
                            style: context.textTheme.headline6!
                                .copyWith(fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            "5,010",
                            style: context.textTheme.headline3!
                                .copyWith(fontSize: 22),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 15),
                    )
                  ],
                ),
                20.0.height,
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey[300]!),
                          shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.boxesPacking,
                          color: Colors.black54,
                          size: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PARCEL DELIVERED TODAY",
                            style: context.textTheme.headline6!
                                .copyWith(fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            "120",
                            style: context.textTheme.headline3!
                                .copyWith(fontSize: 22),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 15),
                    )
                  ],
                ),
                30.0.height,
                Text(
                  "Parcels By Merchant",
                  style: context.textTheme.headline3!.copyWith(fontSize: 17),
                ),
                10.0.height,
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.parcelList.length,
                    itemBuilder: (_, index) {
                      final item = controller.parcelList.elementAt(index);
                      return Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.grey[300]!),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        item.merchantLogo, headers: imageNetworkHeader))),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.merchantName,
                                  style: context.textTheme.headline3!.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                10.0.height,
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: LinearProgressIndicator(
                                        value: (item.count / 280),
                                        color: ColorConstant.primaryColor,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(item.count.toStringAsFixed(0)),
                                        ],
                                      ),

                                    ),
                                  ],
                                ),
                                10.0.height,
                              ],
                            ).paddingSymmetric(horizontal: 15),
                          )
                        ],
                      ).marginOnly(bottom: 10);
                    })
              ],
            ).paddingSymmetric(horizontal: width * 0.04),
          ),
        ),
      ),
    );
  }
}
