import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
        height: 300,
        width: 600,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Text("Revenue"),
                )
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 170,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    child: PieChart(
                      dataMap: pieChartData,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 20.0,
                      chartRadius: MediaQuery.of(context).size.width / 6,
                      showChartValuesInPercentage: true,
                      showChartValues: true,
                      showChartValuesOutside: false,
                      chartValueBackgroundColor: Colors.white,
                      showLegends: false,
                      legendStyle: TextStyle(fontSize: 11),
                      legendPosition: LegendPosition.bottom,
                      decimalPlaces: 1,
                      colorList: colorSet,
                      showChartValueLabel: true,
                      initialAngle: 0,
                      chartValueStyle: defaultChartValueStyle.copyWith(
                          color: Colors.blueGrey[900].withOpacity(0.9),
                          fontSize: 11),
                      chartType: ChartType.disc,
                    ),
                  ),
                ]),
          ],
        ));
  }
}
