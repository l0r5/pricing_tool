import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pricing_tool/themes/color_themes.dart';

class ParameterBarView extends StatelessWidget {
  final List<Widget> paramWidgets;
  final double width;

  ParameterBarView({this.paramWidgets, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: MediaQuery.of(context).size.height,
        color: ColorThemes.primaryColor,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Column(
                children: paramWidgets,
              ),
            ]));
  }
}
