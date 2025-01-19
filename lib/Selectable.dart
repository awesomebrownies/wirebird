import 'package:flutter/material.dart';

class Selectable extends StatelessWidget{
  final String imagePath;
  final String title;
  final String description;
  final String? inspectorSelection;
  final Function onClick;

  const Selectable({super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.inspectorSelection,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = inspectorSelection == title;

    return GestureDetector(
      onTap: () => onClick(),
      child: Stack(
        clipBehavior: Clip.none, // Ensures the border can extend outside the widget
        children: [
          // Border layer
          Positioned(
            top: -6.0, // Negative values to extend the border outward
            bottom: -6.0,
            left: -6.0,
            right: -6.0,
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          // Content layer
          Column(
            children: [
              SizedBox(height: 70, child: Image.asset(imagePath)),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}