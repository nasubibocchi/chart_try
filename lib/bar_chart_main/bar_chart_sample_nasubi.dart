import 'dart:async';
import 'package:chart_try/bar_chart_main/model.dart';
import 'package:chart_try/constants/const.dart';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'datas.dart';

///BarChartSampleNasubi()を呼び出せば棒グラフを表示できるよ
class BarChartSampleNasubi extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _model = ref.watch(modelProvider);
    final _modelState = ref.watch(modelProvider.notifier);
    ref.listen(modelProvider, (touchedIndex) {
      print('touchedIndex changes');
    },);
    //throw UnimplementedError();
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

        ///グラフ背景
        color: kBaseColour,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),

              ///グラフエリア
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    DateTime.now().month.toString() + '月',
                    style: TextStyle(
                        color: kMainColour,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  // Text(
                  //   'nasubi TEST - 20210825',
                  //   style: TextStyle(
                  //       color: const Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  const SizedBox(
                    height: 38,
                  ),

                  ///グラフ本体
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),

                      ///【BarChart(data, swapAnimationDuration, swapAnimationCurve)】を使えば棒グラフが呼び出せる
                      child: BarChart(
                        BarChartData(
                          ///タップした時に出てくる表示
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.blueGrey,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                switch (group.x.toInt()) {
                                  case 0:
                                    _model.weekDay =
                                        (DateTime.now().day - 6).toString() +
                                            '日';
                                    break;
                                  case 1:
                                    _model.weekDay =
                                        (DateTime.now().day - 5).toString() +
                                            '日';
                                    break;
                                  case 2:
                                    _model.weekDay =
                                        (DateTime.now().day - 4).toString() +
                                            '日';
                                    break;
                                  case 3:
                                    _model.weekDay =
                                        (DateTime.now().day - 3).toString() +
                                            '日';
                                    break;
                                  case 4:
                                    _model.weekDay =
                                        (DateTime.now().day - 2).toString() +
                                            '日';
                                    break;
                                  case 5:
                                    _model.weekDay =
                                        (DateTime.now().day - 1).toString() +
                                            '日';
                                    break;
                                  case 6:
                                    _model.weekDay =
                                        DateTime.now().day.toString() + '日';
                                    break;
                                  default:
                                    throw Error();
                                }

                                return BarTooltipItem(
                                  _model.weekDay! + '\n',
                                  TextStyle(
                                    color: kBaseColour,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: (rod.y - 1).toString(),
                                      style: TextStyle(
                                        color: kBaseColour,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            touchCallback: _modelState.BarTouchResponse,
                          ),

                          ///軸データの表示と設定
                          titlesData: FlTitlesData(
                            show: true,

                            ///x軸
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) =>
                                  const TextStyle(
                                      color: kSubColour,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                              margin: 16,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return (DateTime.now().day - 6).toString() +
                                        '日';
                                  case 1:
                                    return (DateTime.now().day - 5).toString() +
                                        '日';
                                  case 2:
                                    return (DateTime.now().day - 4).toString() +
                                        '日';
                                  case 3:
                                    return (DateTime.now().day - 3).toString() +
                                        '日';
                                  case 4:
                                    return (DateTime.now().day - 2).toString() +
                                        '日';
                                  case 5:
                                    return (DateTime.now().day - 1).toString() +
                                        '日';
                                  case 6:
                                    return DateTime.now().day.toString() + '日';
                                  default:
                                    return '';
                                }
                              },
                            ),

                            ///y軸
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) =>
                                  const TextStyle(
                                      color: kSubColour,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                              margin: 16,
                              getTitles: (value) {
                                if (value == 0) {
                                  return '0';
                                } else if (value == 25) {
                                  return '25';
                                } else if (value == 50) {
                                  return '50';
                                } else if (value == 75) {
                                  return '75';
                                } else if (value == 100) {
                                  return '100';
                                } else {
                                  return '';
                                }
                              },
                            ),
                          ),

                          borderData: FlBorderData(
                            show: false,
                          ),

                          //TODO: データ本体。引数に表示させたいデータを指定。サンプルとして"sampleData"@datas.dartを表示している。
                          barGroups: List.generate(
                            7,
                            (i) {
                              switch (i) {
                                case 0:
                                  return _modelState.makeGroupData(
                                      0, sampleData.values.elementAt(0),
                                      isTouched: i == _model.touchedIndex);
                                case 1:
                                  return _modelState.makeGroupData(
                                      1, sampleData.values.elementAt(1),
                                      isTouched: i == _model.touchedIndex);
                                case 2:
                                  return _modelState.makeGroupData(
                                      2, sampleData.values.elementAt(2),
                                      isTouched: i == _model.touchedIndex);
                                case 3:
                                  return _modelState.makeGroupData(
                                      3, sampleData.values.elementAt(3),
                                      isTouched: i == _model.touchedIndex);
                                case 4:
                                  return _modelState.makeGroupData(
                                      4, sampleData.values.elementAt(4),
                                      isTouched: i == _model.touchedIndex);
                                case 5:
                                  return _modelState.makeGroupData(
                                      5, sampleData.values.elementAt(5),
                                      isTouched: i == _model.touchedIndex);
                                case 6:
                                  return _modelState.makeGroupData(
                                      6, sampleData.values.elementAt(6),
                                      isTouched: i == _model.touchedIndex);
                                default:
                                  return throw Error();
                              }
                            },
                          ),
                          // _modelState.showingGroupsNasubi(
                          //     data: sampleData),
                        ),
                        swapAnimationDuration: _model.animDuration,
                        //swapAnimationCurve: Curves.easeOutCubic,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///-----------------------------------------------------------------------
///statefulWidgetの場合
///①以下を有効にする（コメントを外す）
///②datas.dart、model.dartを消去する
///③HookConsumerWidgetを消去する
// class BarChartSampleNasub extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => BarChartSampleNasubiState();
// }
//
// class BarChartSampleNasubiState extends State<BarChartSampleNasubi> {
// ///グラフバーの背景色
// final Color barBackgroundColor = kAccentColour25;
// final Duration animDuration = const Duration(milliseconds: 250);
//
// ///デフォルトで"タップした時の表示"にしておきたいデータインデックスを代入
// int touchedIndex = -1;
//
// bool isPlaying = false;
//
// @override
// Widget build(BuildContext context) {
//   return AspectRatio(
//     aspectRatio: 1,
//     child: Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//
//       ///グラフ背景
//       color: kBaseColour,
//       child: Stack(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(16),
//
//             ///グラフエリア
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Text(
//                   DateTime.now().month.toString() + '月',
//                   style: TextStyle(
//                       color: kMainColour,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 // const SizedBox(
//                 //   height: 4,
//                 // ),
//                 // Text(
//                 //   'nasubi TEST - 20210825',
//                 //   style: TextStyle(
//                 //       color: const Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold),
//                 // ),
//                 const SizedBox(
//                   height: 38,
//                 ),
//
//                 ///グラフ本体
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//
//                     ///【BarChart(data, swapAnimationDuration, swapAnimationCurve)】を使えば棒グラフが呼び出せる
//                     child: BarChart(
//                       mainBarData(),
//                       swapAnimationDuration: animDuration,
//                       //swapAnimationCurve: Curves.easeOutCubic,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// BarChartGroupData makeGroupData(
//   int x,
//   double y, {
//   bool isTouched = false,
//   Color barColor = kAccentColour,
//   double width = 20,
//   List<int> showTooltips = const [],
// }) {
//   return BarChartGroupData(
//     x: x,
//     barRods: [
//       BarChartRodData(
//         ///棒グラフの棒をタップしたら起こることの設定
//         y: isTouched ? y + 1 : y,
//         colors: isTouched ? [Colors.yellow] : [barColor],
//         width: width,
//         borderSide: isTouched
//             ? BorderSide(color: kAccentColour, width: 1)
//             : BorderSide(color: kBaseColour, width: 0),
//         backDrawRodData: BackgroundBarChartRodData(
//           show: true,
//           y: 100,
//           colors: [kMainColour],
//         ),
//       ),
//     ],
//     showingTooltipIndicators: showTooltips,
//   );
// }

// ///仮に9個データ作ってみた。新しいデータはprepend　前に足していってくれるといいです。
// Map<String, double> sampleData = {
//   DateTime.now().day.toString() + '日' : 50.0,
//   (DateTime.now().day - 1).toString() + '日' : 30.0,
//   (DateTime.now().day - 2).toString() + '日' : 10.0,
//   (DateTime.now().day - 3).toString() + '日' : 5.0,
//   (DateTime.now().day - 4).toString() + '日' : 5.0,
//   (DateTime.now().day - 5).toString() + '日' : 15.0,
//   (DateTime.now().day - 6).toString() + '日' : 20.0,
//   (DateTime.now().day - 7).toString() + '日' : 3.0,
//   (DateTime.now().day - 8).toString() + '日' : 5.0,
// };

// ///usage: Map<String, double>型の"data"を引数として設定する。
// List<BarChartGroupData> showingGroupsNasubi({required Map<String, double> data}) =>
//     List.generate(7, (i) {
//       switch (i) {
//         case 0:
//           return makeGroupData(0, data.values.elementAt(0), isTouched: i == touchedIndex);
//         case 1:
//           return makeGroupData(1, data.values.elementAt(1), isTouched: i == touchedIndex);
//         case 2:
//           return makeGroupData(2, data.values.elementAt(2), isTouched: i == touchedIndex);
//         case 3:
//           return makeGroupData(3, data.values.elementAt(3), isTouched: i == touchedIndex);
//         case 4:
//           return makeGroupData(4, data.values.elementAt(4), isTouched: i == touchedIndex);
//         case 5:
//           return makeGroupData(5, data.values.elementAt(5), isTouched: i == touchedIndex);
//         case 6:
//           return makeGroupData(6, data.values.elementAt(6), isTouched: i == touchedIndex);
//         default:
//           return throw Error();
//       }
//     });

// BarChartData mainBarData() {
//   return BarChartData(
//     ///タップした時に出てくる表示
//     barTouchData: BarTouchData(
//       touchTooltipData: BarTouchTooltipData(
//           tooltipBgColor: Colors.blueGrey,
//           getTooltipItem: (group, groupIndex, rod, rodIndex) {
//             // String weekDay;
//             // switch (group.x.toInt()) {
//             //   case 0:
//             //     weekDay = (DateTime.now().day - 6).toString() + '日';
//             //     break;
//             //   case 1:
//             //     weekDay = (DateTime.now().day - 5).toString() + '日';
//             //     break;
//             //   case 2:
//             //     weekDay = (DateTime.now().day - 4).toString() + '日';
//             //     break;
//             //   case 3:
//             //     weekDay = (DateTime.now().day - 3).toString() + '日';
//             //     break;
//             //   case 4:
//             //     weekDay = (DateTime.now().day - 2).toString() + '日';
//             //     break;
//             //   case 5:
//             //     weekDay = (DateTime.now().day - 1).toString() + '日';
//             //     break;
//             //   case 6:
//             //     weekDay = DateTime.now().day.toString() + '日';
//             //     break;
//             //   default:
//             //     throw Error();
//             // }
//
//             return BarTooltipItem(
//               '\n',
//               TextStyle(
//                 color: kBaseColour,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//               children: <TextSpan>[
//                 TextSpan(
//                   text: (rod.y - 1).toString(),
//                   style: TextStyle(
//                     color: kBaseColour,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             );
//           }),
//       touchCallback: (barTouchResponse) {
//         setState(() {
//           if (barTouchResponse.spot != null &&
//               barTouchResponse.touchInput is! PointerUpEvent &&
//               barTouchResponse.touchInput is! PointerExitEvent) {
//             touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
//           } else {
//             touchedIndex = -1;
//           }
//         });
//       },
//     ),
//
//     ///軸データの表示と設定
//     titlesData: FlTitlesData(
//       show: true,
//
//       ///x軸
//       bottomTitles: SideTitles(
//         showTitles: true,
//         getTextStyles: (context, value) => const TextStyle(
//             color: kSubColour, fontWeight: FontWeight.bold, fontSize: 14),
//         margin: 16,
//         getTitles: (double value) {
//           switch (value.toInt()) {
//             case 0:
//               return (DateTime.now().day - 6).toString() + '日';
//             case 1:
//               return (DateTime.now().day - 5).toString() + '日';
//             case 2:
//               return (DateTime.now().day - 4).toString() + '日';
//             case 3:
//               return (DateTime.now().day - 3).toString() + '日';
//             case 4:
//               return (DateTime.now().day - 2).toString() + '日';
//             case 5:
//               return (DateTime.now().day - 1).toString() + '日';
//             case 6:
//               return DateTime.now().day.toString() + '日';
//             default:
//               return '';
//           }
//         },
//       ),
//
//       ///y軸
//       leftTitles: SideTitles(
//         showTitles: true,
//         getTextStyles: (context, value) => const TextStyle(
//             color: kSubColour, fontWeight: FontWeight.bold, fontSize: 14),
//         margin: 16,
//         getTitles: (value) {
//           if (value == 0) {
//             return '0';
//           } else if (value == 25) {
//             return '25';
//           } else if (value == 50) {
//             return '50';
//           } else if (value == 75) {
//             return '75';
//           } else if (value == 100) {
//             return '100';
//           } else {
//             return '';
//           }
//         },
//       ),
//     ),
//
//     borderData: FlBorderData(
//       show: false,
//     ),
//
//     ///データ本体。引数に表示させたいデータを指定。
//     barGroups: showingGroupsNasubi(data: sampleData),
//   );
// }

// Future<dynamic> refreshState() async {
//   setState(() {});
//   await Future<dynamic>.delayed(
//       animDuration + const Duration(milliseconds: 50));
//   if (isPlaying) {
//     await refreshState();
//   }
// }}
