import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pricing_tool/themes/color_themes.dart';

class PremiumPayoutRatioView extends StatelessWidget {
  final List<String> labels;
  final Map<String, double> pieChartData;
  final List<Color> colorSet;
  final double revenue;

  PremiumPayoutRatioView(
      {this.labels, this.pieChartData, this.colorSet, this.revenue});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        width: 1000,
        padding: EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(80, 0, 0, 0),
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "${revenue.toStringAsFixed(2)} CHF",
                    style: TextStyle(
                        color: (revenue < 0)
                            ? ColorThemes.accentColor9
                            : (revenue > 0)
                                ? ColorThemes.accentColor4
                                : Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Revenue",
                    style: TextStyle(
                        color: (revenue < 0)
                            ? ColorThemes.accentColor9
                            : (revenue > 0)
                                ? ColorThemes.accentColor4
                                : Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 170,
                    child: Column(children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "${labels[2]}",
                              style: TextStyle(
                                color: colorSet[1],
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "${labels[0]}",
                              style: TextStyle(
                                color: colorSet[0],
                              ),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${labels[1]}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: colorSet[0],
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              child: Text(
                                " : ",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: colorSet[2],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${labels[3]}",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: colorSet[1],
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ]),
                    ]),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.fromLTRB(0, 0, 30, 10),
                    child: PieChart(
                      dataMap: pieChartData,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 20.0,
                      chartRadius: MediaQuery.of(context).size.width / 6,
                      showChartValuesInPercentage: true,
                      showChartValues: true,
                      showChartValuesOutside: false,
                      chartValueBackgroundColor: ColorThemes.accentColor12,
                      showLegends: false,
                      legendStyle: TextStyle(fontSize: 11),
                      legendPosition: LegendPosition.bottom,
                      decimalPlaces: 1,
                      colorList: colorSet,
                      showChartValueLabel: true,
                      initialAngle: 0,
                      chartValueStyle: defaultChartValueStyle.copyWith(
                          color: Colors.white,
                          fontSize: 11),
                      chartType: ChartType.ring,
                    ),
                  ),
                ]),
          ],
        ));
  }
}
