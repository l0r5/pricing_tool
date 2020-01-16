import 'package:flutter/material.dart';
import 'package:pricing_tool/elements/parameter_input_field.dart';
import 'package:pricing_tool/elements/parameter_slider.dart';

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
      "numberOfDecimals": 2,
      "min": 0,
      "max": 200,
      "divisions": 2000
    },
    1: {
      "id": 1,
      "name": "Premium",
      "numberOfDecimals": 2,
      "value": 0.00,
      "min": 0,
      "max": 200,
      "divisions": 2000
    },
    2: {
      "id": 2,
      "name": "Payout",
      "numberOfDecimals": 2,
      "value": 0.00,
      "min": 0,
      "max": 200,
      "divisions": 2000
    },
    3: {
      "id": 3,
      "name": "Delay",
      "numberOfDecimals": 0,
      "value": 0,
      "min": 0,
      "max": 1000,
      "divisions": 500
    },
  };

  void updateValue(int paramId, double value) {
    setState(() {
      _params[paramId]["value"] = double.parse(
          value.toStringAsFixed(_params[paramId]["numberOfDecimals"]));
    });
  }

  List<Widget> _constructAllParamWidgets() {
    List<Widget> allParamWidgets = [];
    _params
        .forEach((key, value) => allParamWidgets.add(_buildParamWidget(key)));
    return allParamWidgets;
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
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _constructAllParamWidgets()),
      ),
    );
  }
}
