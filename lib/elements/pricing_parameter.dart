import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PricingParameter extends StatelessWidget {

  PricingParameter({label, paramId, initialValue, updateValues}) {
    this.label = label;
    this.paramId = paramId;
    this.textFieldController.text = initialValue.toString();
    this.updateValues = updateValues;
  }

  String label;
  int paramId;
  Function(int, String) updateValues;
  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: textFieldController,
          decoration: InputDecoration(labelText: label),
          keyboardType: TextInputType.number,
          onChanged: (ticketPrice) => updateValues(paramId, ticketPrice)
        ));
  }
}
