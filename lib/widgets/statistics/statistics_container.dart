import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticsContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double height;

  StatisticsContainer(
      {@required this.child,
        this.padding = const EdgeInsets.all(10),
        this.height = 150.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
            )),
        height: height,
        child: Padding(padding: EdgeInsets.all(10), child: child),
      ),
    );
  }
}