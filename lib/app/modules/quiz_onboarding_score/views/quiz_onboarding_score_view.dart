import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';

import '../../../core/widgets/common_button.dart';
import '../../../data/constants/color_constant.dart';
import '../controllers/quiz_onboarding_score_controller.dart';

class QuizOnboardingScoreView extends GetView<QuizOnboardingScoreController> {
  const QuizOnboardingScoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Result"),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: controller.confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  minimumSize: Size(10, 10),
                  maximumSize: Size(10, 10),
                  shouldLoop: false,
                  colors: [
                    ColorConstant.secondaryColor,
                    ColorConstant.titleColor,
                  ],
                ),
              ),
              (controller.result?.isPassed ?? false)
                  ? Image.asset(
                      "assets/images/pass_illustration.png",
                      height: height * 0.45,
                    )
                  : Image.asset("assets/images/failed_illustration.png",
                      height: height * 0.45),
              (controller.result?.totalScore ?? 0) == 0
                  ? const SizedBox.shrink()
                  : 20.0.height,
              (controller.result?.totalScore ?? 0) == 0
                  ? const SizedBox.shrink()
                  : Text(
                      "${controller.result?.score ?? 0} / ${controller.result?.totalScore ?? 0}",
                      style: context.textTheme.headline4!.copyWith(
                          color: (controller.result?.isPassed ?? false)
                              ? ColorConstant.primaryColor
                              : ColorConstant.redColor),
                    ),
              20.0.height,
              (controller.result?.isPassed ?? false)
                  ? Text(
                      "Congratulations!",
                      style: context.textTheme.headline2!
                          .copyWith(color: ColorConstant.primaryColor),
                    )
                  : Text(
                      "Failed",
                      style: context.textTheme.headline2!
                          .copyWith(color: ColorConstant.primaryColor),
                    ),
              5.0.height,
              (controller.result?.isPassed ?? false)
                  ? Text(
                      "You have passed onboarding quizzes. Congratulation!",
                      textAlign: TextAlign.center,
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.grey),
                    )
                  : Text(
                      "You did not passed onboarding quizzes. Please try again later..",
                      textAlign: TextAlign.center,
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.grey),
                    ),
            ],
          ).paddingAll(20),
        ),
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
            title: "Continue",
            callBack: () async {
              Get.back();
            }),
      ),
    );
  }
}
