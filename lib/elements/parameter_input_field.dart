import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParameterInputField extends StatelessWidget {
  ParameterInputField({label, paramId, value, updateValue, focus}) {
    this.paramId = paramId;
    this.label = label;
    this.updateValue = updateValue;
    _textFieldController.text = value.toString();
  }

  String label;
  int paramId;
  double value;
  TextEditingController _textFieldController = TextEditingController();
  Function(int, double) updateValue;

  void _resetField() {
    if (_textFieldController.text == "0") {
      _textFieldController.clear();
    }
  }

  void _updateField(String newValue) {
    _textFieldController.text = newValue;
    updateValue(paramId, double.parse(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(labelText: label, labelStyle: TextStyle(color: Theme.of(context).accentColor)),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onSubmitted: (newValue) => _updateField(newValue),
          onTap: (_textFieldController.text == "0") ? _resetField : null),
    );
  }
}
