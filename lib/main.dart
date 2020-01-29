import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pricing_tool/views/parameter_bar_view.dart';
import 'package:pricing_tool/services/rest_service.dart';
import 'package:pricing_tool/themes/color_themes.dart';
import 'package:pricing_tool/elements/formatted_card.dart';
import 'package:pricing_tool/elements/parameter_input_field.dart';
import 'package:pricing_tool/elements/parameter_slider.dart';
import 'package:pricing_tool/views/premium-payout-ratio_view.dart';
import 'package:pricing_tool/views/total_numbers_circle_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eMobee Pricing Tool',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
//        primarySwatch: Colors.blue,
        primaryColor: ColorThemes.primaryColor,
        accentColor: ColorThemes.accentColor,
      ),
      home: MyHomePage(title: 'eMobee Pricing Tool'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  static const int PARAM_ID_TICKET_PRICE = 0;
  static const int PARAM_ID_PREMIUM_SHARE = 1;
  static const int PARAM_ID_PREMIUM_PRICE = 2;
  static const int PARAM_ID_PREMIUM_NUMBER = 3;
  static const int PARAM_ID_DELAY = 4;
  static const int PARAM_ID_PAYOUT_SHARE = 5;
  static const int PARAM_ID_PAYOUT_AMOUNT = 6;
  static const int PARAM_ID_PAYOUT_NUMBER = 7;

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Logger logger = Logger();

  Map _params = {
    MyHomePage.PARAM_ID_TICKET_PRICE: {
      "id": 0,
      "name": "Ticket Price",
      "value": 0.00,
      "min": 0,
      "max": 60,
      "divisions": 60
    },
    MyHomePage.PARAM_ID_PREMIUM_SHARE: {
      "id": 1,
      "name": "Premium Share of Ticket Price",
      "value": 0,
      "min": 0,
      "max": 100,
      "divisions": 10
    },
    MyHomePage.PARAM_ID_PREMIUM_PRICE: {
      "id": 2,
      "name": "Premium Price",
      "value": 0.00,
      "min": 0,
      "max": 60,
      "divisions": 60
    },
    MyHomePage.PARAM_ID_PREMIUM_NUMBER: {
      "id": 3,
      "name": "Number of collected Premiums",
      "value": 0,
      "min": 0,
      "max": 100000,
      "divisions": 100000
    },
    MyHomePage.PARAM_ID_DELAY: {
      "id": 4,
      "name": "Delay",
      "value": 0,
      "min": 0,
      "max": 10,
      "divisions": 10
    },
    MyHomePage.PARAM_ID_PAYOUT_SHARE: {
      "id": 5,
      "name": "Payout Share of Ticket Price",
      "value": 0,
      "min": 0,
      "max": 100,
      "divisions": 10
    },
    MyHomePage.PARAM_ID_PAYOUT_AMOUNT: {
      "id": 6,
      "name": "Payout Amount",
      "value": 0.00,
      "min": 0,
      "max": 60,
      "divisions": 60
    },
    MyHomePage.PARAM_ID_PAYOUT_NUMBER: {
      "id": 7,
      "name": "Payout Number",
      "value": 0.00,
      "min": 0,
      "max": 100000,
      "divisions": 100000
    },
  };

  double totalPremiumAmount = 0.00;
  double totalPremiumRatio = 0.00;
  double totalPayoutAmount = 0.00;
  double totalPayoutRatio = 0.00;
  double revenue = 0.00;
  Map _historicalDelayData;

  double parameterBarWidth = 370;

  @override
  void initState() {
    super.initState();
    refreshDataFromServer();
  }

  void refreshDataFromServer() async {
    Map response = await RestService().getTotalCountedDelays();
    setState(() {
      _historicalDelayData = response;
    });
  }

  void updateValue(int paramId, double value) {
    if (_params[paramId]["value"] != value) {
      setState(() {
        _params[paramId]["value"] = value;
        _adjustDependedParameters(paramId);
        _calcKeyFigures();
      });
    }
  }

  void _adjustDependedParameters(int paramId) {
    var ticketPrice = _params[MyHomePage.PARAM_ID_TICKET_PRICE]["value"];
    var premiumPrice = _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]["value"];
    var premiumShare = _params[MyHomePage.PARAM_ID_PREMIUM_SHARE]["value"];
    var premiumNumber = _params[MyHomePage.PARAM_ID_PREMIUM_NUMBER]["value"];
    var payoutAmount = _params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]["value"];
    var payoutShare = _params[MyHomePage.PARAM_ID_PAYOUT_SHARE]["value"];
    var delay = _params[MyHomePage.PARAM_ID_DELAY]["value"];

    switch (paramId) {
      case MyHomePage.PARAM_ID_TICKET_PRICE:
        if (ticketPrice > 0 && premiumPrice > 0) {
          _params[MyHomePage.PARAM_ID_PREMIUM_SHARE]["value"] =
              (premiumPrice / ticketPrice) * 100;
        }
        break;
      case MyHomePage.PARAM_ID_PREMIUM_SHARE:
        if (ticketPrice > 0 && premiumShare > 0) {
          _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]["value"] =
              ticketPrice * (premiumShare / 100);
        }
        break;
      case MyHomePage.PARAM_ID_PREMIUM_PRICE:
        if (ticketPrice > 0 && premiumPrice > 0) {
          _params[MyHomePage.PARAM_ID_PREMIUM_SHARE]["value"] =
              (premiumPrice / ticketPrice) * 100;
        }
        break;
      case MyHomePage.PARAM_ID_PREMIUM_NUMBER:
        _params[MyHomePage.PARAM_ID_PREMIUM_NUMBER]["value"] =
            _params[MyHomePage.PARAM_ID_PREMIUM_NUMBER]["value"].round();
        break;
      case MyHomePage.PARAM_ID_DELAY:
        _params[MyHomePage.PARAM_ID_DELAY]["value"] =
            _params[MyHomePage.PARAM_ID_DELAY]["value"].round();
        if (_historicalDelayData != null) {
          var payoutProbability =
              _historicalDelayData["payout-probabilities"][delay.toString()];
          _params[MyHomePage.PARAM_ID_PAYOUT_NUMBER]["value"] =
              (premiumNumber * payoutProbability).round();
        }
        break;
      case MyHomePage.PARAM_ID_PAYOUT_SHARE:
        if (ticketPrice > 0 && payoutShare > 0) {
          _params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]["value"] =
              ticketPrice * (payoutShare / 100);
        }
        break;
      case MyHomePage.PARAM_ID_PAYOUT_AMOUNT:
        if (ticketPrice > 0 && payoutAmount > 0) {
          _params[MyHomePage.PARAM_ID_PAYOUT_SHARE]["value"] =
              (payoutAmount / ticketPrice) * 100;
        }
        break;
      case MyHomePage.PARAM_ID_PAYOUT_NUMBER:
        _params[MyHomePage.PARAM_ID_PAYOUT_NUMBER]["value"] =
            _params[MyHomePage.PARAM_ID_PAYOUT_NUMBER]["value"].round();
        break;
      default:
        break;
    }
  }

  void _calcKeyFigures() {
    _calcTotalPremiumAmount();
    _calcTotalPayoutAmount();
    _calcTotalPremiumRatio();
    _calcTotalPayoutRatio();
    _calcRevenue();
  }

  void _calcTotalPremiumAmount() {
    var premiumPrice = _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]["value"];
    var premiumNumber = _params[MyHomePage.PARAM_ID_PREMIUM_NUMBER]["value"];
    totalPremiumAmount = premiumPrice * premiumNumber;
  }

  void _calcTotalPayoutAmount() {
    var payoutAmount = _params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]["value"];
    var payoutNumber = _params[MyHomePage.PARAM_ID_PAYOUT_NUMBER]["value"];
    totalPayoutAmount = payoutAmount * payoutNumber;
  }

  void _calcTotalPremiumRatio() {
    totalPremiumRatio =
        totalPremiumAmount / (totalPremiumAmount + totalPayoutAmount);
  }

  void _calcTotalPayoutRatio() {
    totalPayoutRatio =
        totalPayoutAmount / (totalPremiumAmount + totalPayoutAmount);
  }

  void _calcRevenue() {
    revenue = totalPremiumAmount - totalPayoutAmount;
  }

  List<Widget> _constructParamWidgets(int start, int end) {
    List<Widget> collectedParamWidgets = [];
    for (; start <= end; start++) {
      collectedParamWidgets.add(_buildParamWidget(start));
    }
    return collectedParamWidgets;
  }

  Widget _buildParamWidget(int paramId) {
    return Container(
        margin: EdgeInsets.fromLTRB(0,0,5,0),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: ColorThemes.accentColor10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                _params[paramId]["name"],
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ParameterSlider(
                  paramId: _params[paramId]["id"],
                  label: _params[paramId]["name"],
                  value: _params[paramId]["value"],
                  min: _params[paramId]["min"],
                  max: _params[paramId]["max"],
                  divisions: _params[paramId]["divisions"],
                  updateValue: updateValue,
                ),
                ParameterInputField(
                  paramId: _params[paramId]["id"],
                  label: _params[paramId]["name"],
                  value: _params[paramId]["value"],
                  updateValue: updateValue,
                ),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
        body: Row(
      children: <Widget>[
        ParameterBarView(
          paramWidgets: _constructParamWidgets(0, _params.length - 1),
          width: parameterBarWidth,
        ),
        Container(
          color: ColorThemes.accentColor11,
          width: MediaQuery.of(context).size.width - parameterBarWidth,
          height: MediaQuery.of(context).size.height,
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: FormattedCard(
                            child: PremiumPayoutRatioView(labels: [
                              "Premium Ratio",
                              "${(totalPremiumRatio * 100) > 0 ? ((totalPremiumRatio * 100) <= 100 ? (totalPremiumRatio * 100).round() : 100) : 0}",
                              "Payout Ratio",
                              "${(totalPayoutRatio * 100) > 0 ? ((totalPayoutRatio * 100) <= 100 ? (totalPayoutRatio * 100).round() : 100) : 0}"
                            ], pieChartData: {
                              "Premiums": totalPremiumRatio > 0
                                  ? (totalPremiumRatio * 100).round()
                                  : 1,
                              "Payouts": totalPayoutRatio > 0
                                  ? (totalPayoutRatio * 100).round()
                                  : 1
                            }, colorSet: [
                              ColorThemes.accentColor2,
                              ColorThemes.accentColor5,
                              ColorThemes.primaryColor
                            ], revenue: revenue),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: FormattedCard(
                            child: TotalNumbersCircleView(
                              labels: [
                                "Total Premium Amount",
                              ],
                              totalParameterAmount: totalPremiumAmount,
                              pieChartData: {
                                (_params[MyHomePage.PARAM_ID_PREMIUM_PRICE]
                                        ["name"]):
                                    _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]
                                        ["value"],
                                _params[MyHomePage.PARAM_ID_TICKET_PRICE]
                                    ["name"]: (_params[MyHomePage
                                                    .PARAM_ID_TICKET_PRICE]
                                                ["value"] <=
                                            0 ||
                                        _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]
                                                ["value"] <=
                                            0)
                                    ? 1
                                    : _params[MyHomePage.PARAM_ID_TICKET_PRICE]
                                            ["value"] -
                                        _params[MyHomePage
                                            .PARAM_ID_PREMIUM_PRICE]["value"]
                              },
                              colorSet: [
                                ColorThemes.accentColor2,
                                ColorThemes.accentColor4
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: FormattedCard(
                            child: TotalNumbersCircleView(
                              labels: [
                                "Total Payout Amount",
                              ],
                              totalParameterAmount: totalPayoutAmount,
                              pieChartData: {
                                (_params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]
                                        ["name"]):
                                    _params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]
                                        ["value"],
                                _params[MyHomePage.PARAM_ID_TICKET_PRICE]
                                    ["name"]: (_params[MyHomePage
                                                    .PARAM_ID_TICKET_PRICE]
                                                ["value"] <=
                                            0 ||
                                        _params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]
                                                ["value"] <=
                                            0)
                                    ? 1
                                    : _params[MyHomePage.PARAM_ID_TICKET_PRICE]
                                            ["value"] -
                                        _params[MyHomePage
                                            .PARAM_ID_PAYOUT_AMOUNT]["value"]
                              },
                              colorSet: [
                                ColorThemes.accentColor5,
                                ColorThemes.accentColor4,
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ]),
        )
      ],
    ));
  }
}
