import 'package:flutter/cupertino.dart';

class Selectable extends StatelessWidget{
  final String imagePath;
  final String description;

  const Selectable({super.key,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70, child: Image.asset(imagePath)),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}