import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: Get.width * 0.035),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(bottom: Get.width * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          color: Colors.white,
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.25,
                    height: constraints.maxWidth * 0.25,
                    child: Align(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.white70,
                      child: Container(
                        width: (constraints.maxWidth * 0.25) * 0.75,
                        height: (constraints.maxWidth * 0.25) * 0.75,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[200]),
                      ),
                    )),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.5,
                    height: constraints.maxWidth * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.white70,
                          child: Container(
                              width: (constraints.maxWidth * 0.5),
                              height: 15,
                              decoration:
                                  BoxDecoration(color: Colors.grey[200])),
                        ),
                        SizedBox(height: 3),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.white70,
                          child: Container(
                              width: (constraints.maxWidth * 0.5) * 0.5,
                              height: 15,
                              decoration:
                                  BoxDecoration(color: Colors.grey[200])),
                        ),
                        SizedBox(height: 10),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.white70,
                          child: Container(
                              width: (constraints.maxWidth * 0.5) * 0.25,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(13.0))),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
