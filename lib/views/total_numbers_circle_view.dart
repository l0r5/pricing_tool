import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class TotalNumbersCircleView extends StatelessWidget {
  final List<String> labels;
  final double totalParameterAmount;
  final Map<String, double> pieChartData;
  final List<Color> colorSet;

  TotalNumbersCircleView(
      {this.labels, this.totalParameterAmount, this.pieChartData, this.colorSet}) {
//    _pieChartData = {"${labels[0]}": parameterAmount, "Ticket Price": ticketPrice};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 200,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        PieChart(
          dataMap: pieChartData,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 20.0,
          chartRadius: MediaQuery.of(context).size.width / 10,
          showChartValuesInPercentage: true,
          showChartValues: true,
          showChartValuesOutside: false,
          chartValueBackgroundColor: Colors.white,
          showLegends: true,
          legendStyle: TextStyle(fontSize: 11),
          legendPosition: LegendPosition.bottom,
          decimalPlaces: 1,
          colorList: colorSet,
          showChartValueLabel: true,
          initialAngle: 0,
          chartValueStyle: defaultChartValueStyle.copyWith(
              color: Colors.blueGrey[900].withOpacity(0.9), fontSize: 11),
          chartType: ChartType.disc,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${totalParameterAmount.toStringAsFixed(2)} CHF",
                  style: TextStyle(
                      fontSize: 20,
                      color: colorSet[0],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${labels[0]}",
                  style: TextStyle(color: colorSet[0]),
                ),
              ]),
        )
      ]),
    );
  }
}
