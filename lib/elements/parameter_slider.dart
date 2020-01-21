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
        width: 260,
        child: Row(
      children: <Widget>[
        Text(
          "$min",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
        Container(
          width: 200,
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
        Text((max < 10000) ? "$max" : (max < 1000000) ? "${max/1000} k" : "${max/1000000} mio",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ))
      ],
    ));
  }
}
