import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSearchJobBiddingScreen extends StatelessWidget {
  const ShimmerSearchJobBiddingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
            itemCount: 4,
            itemBuilder: (context, index) => Container(
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
                            baseColor: Colors.grey[100]!,
                            highlightColor: Colors.white70,
                            child: Container(
                              width: (constraints.maxWidth * 0.25) * 0.75,
                              height: (constraints.maxWidth * 0.25) * 0.75,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[100]),
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
                                baseColor: Colors.grey[100]!,
                                highlightColor: Colors.white70,
                                child: Container(
                                    width: (constraints.maxWidth * 0.5) * 1,
                                    height: 15,
                                    color: Colors.grey[100]),
                              ),
                              SizedBox(height: 5.0),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[100]!,
                                highlightColor: Colors.white70,
                                child: Container(
                                    width: (constraints.maxWidth * 0.5) * 0.6,
                                    height: 15,
                                    color: Colors.grey[100]),
                              ),
                              SizedBox(height: 10),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[100]!,
                                highlightColor: Colors.white70,
                                child: Container(
                                  width: (constraints.maxWidth * 0.5) * 0.3,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius:
                                          BorderRadius.circular(13.0)),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 8.0)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )),
    ));
  }
}
