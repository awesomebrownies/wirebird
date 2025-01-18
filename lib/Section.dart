import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget{
  final String title;
  final Color color;
  final Widget child;

  const Section({super.key,
    required this.title,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    screenWidth *= 0.75;

    return Container(
      color: color,
      child: Center(
        child: SizedBox(
          width: screenWidth,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}