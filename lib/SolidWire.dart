import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SolidWire extends StatelessWidget{
  final double width;
  final bool activated;
  final double? height;

  const SolidWire({super.key,
    required this.width,
    required this.activated,
    this.height,
  });

  @override
  Widget build(BuildContext context){
    Color color = Colors.black12;
    if (activated) {
      color = Colors.black38;
    }

    return SizedBox(
      width: width,
      child: Divider(
        height: height ?? 3,
        thickness: height ?? 3,
        color: color,
      ),
    );
  }
}