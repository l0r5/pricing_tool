import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pricing_tool/themes/color_themes.dart';

class FormattedCard extends StatelessWidget {
  final Widget child;

  FormattedCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: ColorThemes.accentColor12,
      child: child,
    );
  }
}
