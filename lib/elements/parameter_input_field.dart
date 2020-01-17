import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParameterInputField extends StatelessWidget {
  ParameterInputField({label, paramId, value, updateValue}) {
    this.paramId = paramId;
    this.label = label;
    this.updateValue = updateValue;
    this.value = value;
    this._textFieldController = TextEditingController.fromValue(
        TextEditingValue(
            text: value.toString(),
            selection:
                TextSelection.collapsed(offset: value.toString().length)));
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
    updateValue(paramId, double.parse(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(labelText: label),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) => _updateField(newValue),
          onTap: (_textFieldController.text == "0") ? _resetField : null),
    );
  }
}
