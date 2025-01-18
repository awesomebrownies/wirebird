import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        SolidWire(width: 3, height: 20, activated: connected),
        Selectable(
            imagePath: 'assets/images/server_rack.png',
            title: 'Proxy Server',
            description: 'Not Selected',
            inspectorSelection: inspectorSelection,
            onClick: () => setSelected("Proxy Server"),),
        SolidWire(width: 3, height: 20, activated: connected),
      ],
    );
  }
}