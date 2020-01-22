import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      color: Colors.white,
      child: child,
    );
  }
}
