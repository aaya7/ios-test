import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHighlightTalent extends StatelessWidget {
  const ShimmerHighlightTalent({Key? key, required this.constraints}) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 20.0),
      shrinkWrap: true,
      //item length
      itemCount: 2,
      itemBuilder: (context, index) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(right: 18.0),
          width: constraints.maxWidth * 0.36,
          height: constraints.maxHeight * 0.95,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400]!, spreadRadius: 0, blurRadius: 2.0)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                // Positioned.fill(
                //     //Network image
                //     child: Container(
                //     decoration: BoxDecoration(color: Colors.red),
                //   )),
                //Opacity layer
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     height: (constraints.maxHeight * 0.95) * 0.35,
                //     color: Colors.black.withOpacity(0.2),
                //   ),
                // ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5.0),
                    height: (constraints.maxHeight * 0.95) * 0.3,
                    width: constraints.maxWidth * 0.31,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Talent name
                        Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.white70,
                          child: Container(
                            width: constraints.maxWidth * 0.85,
                            height: 10,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Follower component
                            Row(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[200]!,
                                  highlightColor: Colors.white70,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                SizedBox(width: 3.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.white70,
                                      child: Container(
                                        width: constraints.maxWidth * 0.05,
                                        height: 9,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.white70,
                                      child: Container(
                                        width: constraints.maxWidth * 0.08,
                                        height: 7,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            //Likes component
                            Row(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[200]!,
                                  highlightColor: Colors.white70,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                SizedBox(width: 3.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.white70,
                                      child: Container(
                                        width: constraints.maxWidth * 0.05,
                                        height: 9,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.white70,
                                      child: Container(
                                        width: constraints.maxWidth * 0.08,
                                        height: 7,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
