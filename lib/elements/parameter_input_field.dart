import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParameterInputField extends StatelessWidget {
  ParameterInputField({label, paramId, value, updateValue}) {
    this.paramId = paramId;
    this.label = label;
    this.textFieldController.text = value.toString();
    this.updateValue = updateValue;
  }

  String label;
  int paramId;
  Function(int, double) updateValue;
  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
            controller: textFieldController,
            decoration: InputDecoration(labelText: label),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (newValue) =>
                updateValue(paramId, double.parse(newValue))));
  }
}
