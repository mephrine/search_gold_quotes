import 'package:flutter/material.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 14,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  0.0, 0.0, 0.0, Dimens.mainTabBarCurveMargin),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 100,
              ),
            ),
          ]),
        ));
  }
}
