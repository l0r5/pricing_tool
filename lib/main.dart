import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pricing_tool/elements/parameter_input_field.dart';
import 'package:pricing_tool/elements/parameter_slider.dart';
import 'package:pricing_tool/elements/premium_payout_ratio.dart';

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
  static const int PARAM_ID_NUMBER_PREMIUMS = 3;
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
    MyHomePage.PARAM_ID_NUMBER_PREMIUMS: {
      "id": 3,
      "name": "Number of collected Premiums",
      "value": 0,
      "min": 0,
      "max": 1000000,
      "divisions": 1000000
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
      "max": 1000000,
      "divisions": 1000000
    },
  };

  void updateValue(int paramId, double value) {
    if (_params[paramId]["value"] != value) {
      setState(() {
        _params[paramId]["value"] = value;
        _adjustDependedParameters(paramId);
      });
    }
  }

//  PARAM_ID_TICKET_PRICE = 0;
//  PARAM_ID_PREMIUM_SHARE = 1;
//  PARAM_ID_PREMIUM_PRICE = 2;
//  PARAM_ID_NUMBER_PREMIUMS =
//  PARAM_ID_DELAY = 4;
//  PARAM_ID_PAYOUT_SHARE = 5;
//  PARAM_ID_PAYOUT_AMOUNT = 6;
//  PARAM_ID_PAYOUT_NUMBER = 7;

  void _adjustDependedParameters(int paramId) {
    double ticketPrice = _params[MyHomePage.PARAM_ID_TICKET_PRICE]["value"];
    double premiumPrice = _params[MyHomePage.PARAM_ID_PREMIUM_PRICE]["value"];
    double premiumShare = _params[MyHomePage.PARAM_ID_PREMIUM_SHARE]["value"];
    double payoutAmount = _params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]["value"];
    double payoutShare = _params[MyHomePage.PARAM_ID_PAYOUT_SHARE]["value"];

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
              ticketPrice * (premiumShare/100);
        }
        break;
      case MyHomePage.PARAM_ID_PREMIUM_PRICE:
        if (ticketPrice > 0 && premiumPrice > 0) {
          _params[MyHomePage.PARAM_ID_PREMIUM_SHARE]["value"] =
              (premiumPrice / ticketPrice) * 100;
        }
        break;
      case MyHomePage.PARAM_ID_PAYOUT_SHARE:
        if (ticketPrice > 0 && payoutShare > 0) {
          _params[MyHomePage.PARAM_ID_PAYOUT_AMOUNT]["value"] =
              ticketPrice * (payoutShare/100);
        }
        break;
      case MyHomePage.PARAM_ID_PAYOUT_AMOUNT:
        if (ticketPrice > 0 && payoutAmount > 0) {
          _params[MyHomePage.PARAM_ID_PAYOUT_SHARE]["value"] =
              (payoutAmount / ticketPrice) * 100;
        }
        break;
      default:
        break;
    }
  }

  List<Widget> _constructParamWidgets(int start, int end) {
    List<Widget> collectedParamWidgets = [];
    for (; start <= end; start++) {
      collectedParamWidgets.add(_buildParamWidget(start));
    }
//    _params
//        .forEach((key, value) => collectedParamWidgets.add(_buildParamWidget(key)));
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
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                    child: PremiumPayoutRatio(
//                      premiumAmount:  _params[1]["value"],
//                      premiumNumber: _params[2]["value"],
//                      payoutAmount: _params[3]["value"],
//                      payoutNumber: _params[4]["value"],
//                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _constructParamWidgets(0, 3)),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _constructParamWidgets(4, 7)),
                        ],
                      ))
                ],
              )
            ]));
  }
}
