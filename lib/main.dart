import 'package:flutter/material.dart';
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
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map _params = {
    0: {
      "id": 0,
      "name": "Ticket Price",
      "value": 0.00,
      "min": 0,
      "max": 200,
      "divisions": 20000
    },
    1: {
      "id": 1,
      "name": "Premium Share of Ticket Price",
      "value": 0,
      "min": 0,
      "max": 100,
      "divisions": 10000
    },
    2: {
      "id": 2,
      "name": "Premium Amount",
      "value": 0.00,
      "min": 0,
      "max": 200,
      "divisions": 20000
    },
    3: {
      "id": 3,
      "name": "Number of collected Premiums",
      "value": 0,
      "min": 0,
      "max": 1000000,
      "divisions": 1000000
    },
    4: {
      "id": 4,
      "name": "Delay",
      "value": 0,
      "min": 0,
      "max": 120,
      "divisions": 120
    },
    5: {
      "id": 5,
      "name": "Payout Share of Ticket Price",
      "value": 0,
      "min": 0,
      "max": 100,
      "divisions": 10000
    },
    6: {
      "id": 6,
      "name": "Payout Amount",
      "value": 0.00,
      "min": 0,
      "max": 200,
      "divisions": 20000
    },
    7: {
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
      });
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
                      padding:
                          EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _constructParamWidgets(0, 3)
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _constructParamWidgets(4, 7)
                          ),
                        ],
                      ))
                ],
              )
            ]));
  }
}
