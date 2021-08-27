
import 'package:chart_try/constants/const.dart';
import 'package:flutter/material.dart';

import 'bar_chart_sample_nasubi.dart';

class BarChartPageNasubi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColour,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: BarChartSampleNasubi(),
        ),
      ),
    );
  }
}
