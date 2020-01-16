import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParameterSlider extends StatelessWidget {
  ParameterSlider({paramId, label, value, min, max, divisions, updateValue}) {
    this.paramId = paramId;
    this.label = label;
    this.value = value;
    this.min = min;
    this.max = max;
    this.divisions = divisions;
    this.updateValue = updateValue;

    _ensureBoundaries(value);
  }

  int paramId;
  String label;
  double value;
  double min;
  double max;
  int divisions;
  Function(int, double) updateValue;

  void _ensureBoundaries(double value) {
    if (value > max) {
      this.value = max;
    }
    if (value < min) {
      this.value = min;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Text("$min"),
        Container(
          width: 400,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Slider(
            label: "$label: $value",
            activeColor: Colors.blue,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: (newValue) => updateValue(paramId, newValue),
            value: value,
          ),
        ),
        Text("$max"),
      ],
    ));
  }
}
