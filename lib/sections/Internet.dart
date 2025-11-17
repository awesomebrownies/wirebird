import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DottedWireless.dart';
import '../Selectable.dart';
import '../SolidWire.dart';

class Internet extends StatelessWidget{
  final bool connected;

  final Function setSelected;
  final String? inspectorSelection;

  const Internet({super.key,
    required this.connected,

    required this.setSelected,
    required this.inspectorSelection,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SolidWire(width: 3, height: 20, activated: connected),
        Selectable(
            imagePath: 'assets/images/server_rack.png',
            title: 'VPN Server',
            description: 'Custom',
            inspectorSelection: inspectorSelection,
            onClick: () => setSelected("VPN Server"),),
        // SolidWire(width: 3, height: 20, activated: connected),
        const AnimatedLineConnector(
            distance: 30,
            angle: 1.57079,
            color: Colors.black38,
            spacing: 20.0,
            dotSize: 1.0,
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}