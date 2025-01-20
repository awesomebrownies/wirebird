import 'package:flutter/cupertino.dart';

class Field extends StatelessWidget{
  final String name;
  final String? value;

  Field({super.key,
    required this.name,
    this.value,
  });

  @override
  Widget build(BuildContext context){
    return Text(
        "$name: ${value ?? 'Not Set'}"
    );
  }
}