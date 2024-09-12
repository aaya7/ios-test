import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_no_data_error.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/core/widgets/info_dialog.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/modules/onboarding/controllers/onboarding_quizzes_controller.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/widgets/common_appbar.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/register_checklist_header_widget.dart';
import '../../../core/widgets/shimmer/shimmerlistview.dart';
import '../../../data/models/auth_models/checklist_personal_info_models/checklist_onboarding_quizes_model.dart';

class OnboardingQuizzesView extends GetView<OnboardingQuizzesController> {
  const OnboardingQuizzesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CommonAppBar(
          context: context, title: controller.title ?? "Onboarding Quiz"),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return controller.isLoading.isTrue
                    ? const ShimmerListView()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          20.0.height,
                          YoutubePlayer(
                            controller: controller.youtubeController ??
                                YoutubePlayerController(initialVideoId: ""),
                            showVideoProgressIndicator: true,
                            onEnded: (data) {
                              controller.videoWatched.value = true;
                              snackBarSuccess(
                                  context: context,
                                  content:
                                      "Congratulations, you have watched video completely");
                            },
                          ),
                          20.0.height,
                          (controller.quizModel.value.onboardingQuiz?.quizzes ??
                                      <Quiz>[])
                                  .isEmpty
                              ? Text(
                                  "Please watch this video until the end of video to complete this quiz. Otherwise, this quiz will remain uncompleted",
                                  style: context.textTheme.headline6!
                                      .copyWith(color: Colors.grey),
                                )
                              : const SizedBox.shrink(),
                          ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: (controller.quizModel.value
                                          .onboardingQuiz?.quizzes ??
                                      <Quiz>[])
                                  .length,
                              itemBuilder: (_, index) {
                                final item = (controller.quizModel.value
                                            .onboardingQuiz?.quizzes ??
                                        <Quiz>[])
                                    .elementAt(index);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${index + 1}.  ${item.question ?? ''}",
                                      style: context.textTheme.headline3!
                                          .copyWith(),
                                    ),
                                    20.0.height,
                                    ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: item.choices?.length ?? 0,
                                        itemBuilder: (context, index2) {
                                          var answer =
                                              item.choices?.elementAt(index2);

                                          return Obx(() {
                                            bool isSelected =
                                                item.myAnswers?.value == answer;
                                            return Container(
                                              padding: const EdgeInsets.all(15),
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: isSelected
                                                          ? Colors.green
                                                          : Colors.grey[300]!),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                answer ?? '',
                                                style: context
                                                    .textTheme.headline6!
                                                    .copyWith(
                                                        color: Colors.black54),
                                              ),
                                            );
                                          }).onTap(() {
                                            if(!controller.isReadOnly){
                                              item.myAnswers?.value =
                                                  answer ?? '';
                                              item.myAnswers?.refresh();
                                              item.indexAnswer =
                                                  controller.findIndexByAnswer(
                                                      item.choices ?? <String>[],
                                                      item.myAnswers?.value ??
                                                          '');
                                            }

                                          });
                                        }),
                                    Divider(
                                      color: Colors.grey[300],
                                      thickness: 0.5,
                                    )
                                  ],
                                ).marginOnly(bottom: 10);
                              }),
                        ],
                      );
              }),
            ],
          ).paddingSymmetric(horizontal: width * 0.04),
        ),
      ),
      bottomNavigationBar: controller.isReadOnly
          ? const SizedBox.shrink()
          : Obx(() {
              return controller.videoWatched.isTrue
                  ? Container(
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
                          title: "Continue",
                          callBack: () async {
                            if (controller.isAllAnswered()) {
                              controller.submitAnswers();
                            } else {
                              Get.dialog(InfoDialog(
                                  title: "Answer All Question",
                                  info:
                                      "Please answer all question given to proceed to next step",
                                  confirmText: "OKAY"));
                            }
                          }),
                    )
                  : Container(
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
                        title: "Continue",
                        callBack: () async {
                          snackBarFailed(
                              context: context,
                              content: "Please watch video until end");
                        },
                        buttonColor: Colors.grey,
                      ),
                    );
            }),
    );
  }
}
