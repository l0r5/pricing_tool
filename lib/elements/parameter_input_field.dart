import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pricing_tool/themes/color_themes.dart';

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
      width: 50,
      height: 40,
      child: TextField(
          controller: _textFieldController,
          style: TextStyle(color: Colors.white),
          cursorColor: ColorThemes.accentColor9,
          decoration: InputDecoration(
//            labelText: label,
//            labelStyle: TextStyle(color: ColorThemes.accentColor9),
//            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorThemes.accentColor9),
            ),

          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onSubmitted: (newValue) => _updateField(newValue),
          onTap: (_textFieldController.text == "0") ? _resetField : null),
    );
  }
}
