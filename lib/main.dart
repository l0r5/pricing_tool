import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pricing_tool/elements/parameter_input_field.dart';
import 'package:pricing_tool/elements/parameter_slider.dart';
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
        primarySwatch: Colors.blue,
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
      "max": 100,
      "divisions": 10000
    },
    MyHomePage.PARAM_ID_PREMIUM_SHARE: {
      "id": 1,
      "name": "Premium Share of Ticket Price",
      "value": 0,
      "min": 0,
      "max": 100,
      "divisions": 10000
    },
    MyHomePage.PARAM_ID_PREMIUM_PRICE: {
      "id": 2,
      "name": "Premium Price",
      "value": 0.00,
      "min": 0,
      "max": 100,
      "divisions": 10000
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
      "max": 120,
      "divisions": 120
    },
    MyHomePage.PARAM_ID_PAYOUT_SHARE: {
      "id": 5,
      "name": "Payout Share of Ticket Price",
      "value": 0,
      "min": 0,
      "max": 100,
      "divisions": 10000
    },
    MyHomePage.PARAM_ID_PAYOUT_AMOUNT: {
      "id": 6,
      "name": "Payout Amount",
      "value": 0.00,
      "min": 0,
      "max": 200,
      "divisions": 20000
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

  double _totalPremiumAmount = 0.00;
  double _totalPremiumRatio = 0.00;
  double _totalPayoutAmount = 0.00;
  double _totalPayoutRatio = 0.00;

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
    var payoutAmount = _params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]["value"];
    var payoutShare = _params[MyHomePage.PARAM_ID_PAYOUT_SHARE]["value"];

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
            _params[MyHomePage.PARAM_ID_PREMIUM_NUMBER]["value"] as int;
        break;
      case MyHomePage.PARAM_ID_DELAY:
        _params[MyHomePage.PARAM_ID_DELAY]["value"] =
            _params[MyHomePage.PARAM_ID_DELAY]["value"] as int;
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
            _params[MyHomePage.PARAM_ID_PAYOUT_NUMBER]["value"] as int;
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
  }

  void _calcTotalPremiumAmount() {
    var premiumPrice = _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]["value"];
    var premiumNumber = _params[MyHomePage.PARAM_ID_PREMIUM_NUMBER]["value"];
    _totalPremiumAmount = premiumPrice * premiumNumber;
  }

  void _calcTotalPayoutAmount() {
    var payoutAmount = _params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]["value"];
    var payoutNumber = _params[MyHomePage.PARAM_ID_PAYOUT_NUMBER]["value"];
    _totalPayoutAmount = payoutAmount * payoutNumber;
  }

  void _calcTotalPremiumRatio() {
    _totalPremiumRatio =
        _totalPremiumAmount / (_totalPremiumAmount + _totalPayoutAmount);
  }

  void _calcTotalPayoutRatio() {
    _totalPayoutRatio =
        _totalPayoutAmount / (_totalPremiumAmount + _totalPayoutAmount);
  }

  List<Widget> _constructParamWidgets(int start, int end) {
    List<Widget> collectedParamWidgets = [];
    for (; start <= end; start++) {
      collectedParamWidgets.add(_buildParamWidget(start));
    }
    return collectedParamWidgets;
  }

  Widget _buildParamWidget(int paramId) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ParameterInputField(
          paramId: _params[paramId]["id"],
          label: _params[paramId]["name"],
          value: _params[paramId]["value"],
          updateValue: updateValue,
        ),
        ParameterSlider(
          paramId: _params[paramId]["id"],
          label: _params[paramId]["name"],
          value: _params[paramId]["value"],
          min: _params[paramId]["min"],
          max: _params[paramId]["max"],
          divisions: _params[paramId]["divisions"],
          updateValue: updateValue,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            color: Color.fromRGBO(245, 248, 251, 1.0),
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: Card(
                          elevation: 1,
                          child: TotalNumbersCircleView(
                            labels: [
                              "Total Premium Amount",
                            ],
                            totalParameterAmount: _totalPremiumAmount,
                            pieChartData: {
                              (_params[MyHomePage.PARAM_ID_PREMIUM_PRICE]
                                      ["name"]):
                                  _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]
                                      ["value"],
                              _params[MyHomePage.PARAM_ID_TICKET_PRICE]["name"]:
                              (_params[MyHomePage.PARAM_ID_TICKET_PRICE]["value"] <=0 || _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]["value"] <= 0) ? 1 : _params[MyHomePage.PARAM_ID_TICKET_PRICE]["value"] - _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]
                              ["value"]
                            },
                            colorSet: [Color.fromRGBO(117, 104, 232, 1.0), Color.fromRGBO(139, 210, 127, 1.0)],
                          ),
                        ),
                      ),
                      Container(
                          height: 300,
                          margin: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: Card(
                              elevation: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: _constructParamWidgets(0, 3)),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: _constructParamWidgets(4, 7)),
                                ],
                              )))
                    ],
                  )
                ])));
  }
}
