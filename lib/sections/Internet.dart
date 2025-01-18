import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wirebird/ConnectionButton.dart';

import '../Selectable.dart';
import '../SolidWire.dart';

class Internet extends StatelessWidget{
  final bool connected;
  final VoidCallback toggleConnection;

  const Internet({super.key,
    required this.connected,
    required this.toggleConnection,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SolidWire(width: 3, height: 6, activated: connected),
        ConnectionButton(connected: connected, toggleConnection: toggleConnection),
        SolidWire(width: 3, height: 20, activated: connected),
        const Selectable(imagePath: 'assets/images/server_rack.png', description: 'Not Selected'),
        SolidWire(width: 3, height: 20, activated: connected),
      ],
    );
  }
}