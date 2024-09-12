import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_no_data_error.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/modules/onboarding/bindings/onboarding_quizzes_binding.dart';
import 'package:hero/app/modules/onboarding/views/onboarding_quizzes_view.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/widgets/common_appbar.dart';
import '../../../core/widgets/register_checklist_header_widget.dart';
import '../../../core/widgets/shimmer/shimmerlistview.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Onboarding"),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
            const RegisterChecklistHeaderWidget(
                icon: FontAwesomeIcons.graduationCap,
                title: "Onboarding",
                subtitle:
                    "Complete the questionnaire and quizzes below before you can start your job"),
            30.0.height,
            Expanded(
              child: Obx(() {
                return controller.isLoading.isTrue
                    ? const ShimmerListView()
                    : (controller.onboardingChecklist).isEmpty
                        ? const CommonNoDataErrorWidget(
                            content: "No Onboarding Data",
                          )
                        : ListView.builder(
                            itemCount: (controller.onboardingChecklist).length,
                            itemBuilder: (_, index) {
                              final item = controller.onboardingChecklist
                                  .elementAt(index);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ((item.isPassed ?? 0) == 1)
                                          ? const Icon(
                                              LineIcons.check,
                                              color: Colors.green,
                                              size: 15,
                                            )
                                          : const Icon(
                                              LineIcons.times,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                      10.0.width,
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title ?? '',
                                            style: context.textTheme.headline3!
                                                .copyWith(),
                                          ),
                                          10.0.height,
                                          Text(
                                            ((item.isPassed ?? 0) == 1)
                                                ? "Completed successfully"
                                                : "Not completed yet",
                                            style: context.textTheme.headline6!
                                                .copyWith(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      (item.totalScore == null)
                                          ? const SizedBox.shrink()
                                          : Text(
                                              "${item.score ?? 0}/${item.totalScore ?? 0}",
                                              style: context
                                                  .textTheme.headline3!
                                                  .copyWith(),
                                            ),
                                      10.0.width,
                                      const Icon(
                                        FontAwesomeIcons.chevronRight,
                                        color: Colors.grey,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                    thickness: 0.5,
                                  )
                                ],
                              ).onTap(() {
                                Get.to(()=> const OnboardingQuizzesView(), binding: OnboardingQuizzesBinding(), arguments: {
                                  "assignment":controller.assignmentUUID ??'',
                                  "quiz":item.uuid ?? '',
                                  "title":item.title ?? '',
                                  "read_only": (item.isPassed ?? 0) == 1,
                                });
                              }).marginOnly(bottom: 10);
                            });
              }),
            ),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}
