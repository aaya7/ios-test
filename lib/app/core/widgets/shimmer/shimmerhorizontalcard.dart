import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHorizontalCard extends StatelessWidget {
  const ShimmerHorizontalCard({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth * 1,
      height: constraints.maxWidth * 0.4854,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) => Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(right: 18.0),
            width: constraints.maxWidth * 0.6,
            height: constraints.maxWidth * 0.4518,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.white70,
                        child: Container(
                          width: 53,
                          height: 53,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[200]),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.white70,
                        child: Container(
                            width: 60,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(13.0))),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.white70,
                      child: Container(
                          color: Colors.grey[200], width: 190, height: 23)),
                  SizedBox(height: 5.0),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.white70,
                    child: Container(
                      color: Colors.grey[200],
                      width: 120,
                      height: 23,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.white70,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200]),
                            ),
                          ),
                          SizedBox(width: 3.0),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.white70,
                            child: Container(
                              color: Colors.grey[200],
                              width: 70,
                              height: 14,
                            ),
                          )
                        ],
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.white70,
                        child: Container(
                          color: Colors.grey[200],
                          width: 60,
                          height: 14,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}