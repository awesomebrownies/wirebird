import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Selectable extends StatelessWidget{
  final String imagePath;
  final String description;
  final String? inspectorSelection;
  final Function onClick;

  const Selectable({super.key,
    required this.imagePath,
    required this.description,
    required this.inspectorSelection,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = inspectorSelection == description;

    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2.0,
          )
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 70, child: Image.asset(imagePath)),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.black,
              )
            ),
          ],
        ),
      ),
    );
  }
}