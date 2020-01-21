import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PremiumPayoutRatio extends StatelessWidget {
  PremiumPayoutRatio({
    this.premiumAmount,
    this.premiumNumber,
    this.payoutAmount,
    this.payoutNumber,
  }) {
    _calcTotalPremiumRatio(this.premiumAmount, this.premiumNumber,
        this.payoutAmount, this.payoutNumber);
    _calcTotalPayoutRatio(this.premiumAmount, this.premiumNumber,
        this.payoutAmount, this.payoutNumber);
  }

  final double premiumAmount;
  final int premiumNumber;
  final double payoutAmount;
  final int payoutNumber;

  double _totalPremiumRatio = 1;
  double _totalPayoutRatio = 1;

  Map<String, double> _dataMap = {"premiums": 2, "payouts": 1};

  void _calcTotalPremiumRatio(double premiumAmount, int premiumNumber,
      double payoutAmount, int payoutNumber) {
    _totalPremiumRatio = (premiumAmount * premiumNumber) /
        ((premiumAmount * premiumNumber) + (payoutAmount * payoutNumber));
    _dataMap["premiums"] = _totalPremiumRatio;
  }

  void _calcTotalPayoutRatio(double premiumAmount, int premiumNumber,
      double payoutAmount, int payoutNumber) {
    _totalPayoutRatio = (payoutAmount * payoutNumber) /
        ((premiumAmount * premiumNumber) + (payoutAmount * payoutNumber));
    _dataMap["payouts"] = _totalPayoutRatio;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("Total Premium Sum"),
                Text("${premiumAmount * premiumNumber}"),
              ],
            ),
            Column(
              children: <Widget>[
                Text("Total Payout Sum"),
                Text("${payoutAmount * payoutNumber}"),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("Total Premium Ratio"),
                Text("$_totalPremiumRatio"),
              ],
            ),
            Column(
              children: <Widget>[
                Text("Total Payout Ratio"),
                Text("$_totalPayoutRatio"),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            PieChart(
              dataMap: _dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32.0,
              chartRadius: MediaQuery.of(context).size.width / 6,
              showChartValuesInPercentage: true,
              showChartValues: true,
              showChartValuesOutside: false,
              chartValueBackgroundColor: Colors.grey[200],
              showLegends: true,
              legendPosition: LegendPosition.right,
              decimalPlaces: 1,
              showChartValueLabel: true,
              initialAngle: 0,
              chartValueStyle: defaultChartValueStyle.copyWith(
                color: Colors.blueGrey[900].withOpacity(0.9),
              ),
              chartType: ChartType.disc,
            )
          ],
        ),
      ],
    ));
  }
}
