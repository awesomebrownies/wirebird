import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wirebird/Selectable.dart';

import '../DottedWireless.dart';

class LocalNetwork extends StatelessWidget{
    final String? wifiName;
    final String? userName;
    final String? hostName;

    final Function setSelected;
    final String? inspectorSelection;

    const LocalNetwork({super.key,
      this.wifiName,
      this.userName,
      this.hostName,

      required this.setSelected,
      required this.inspectorSelection,
    });

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Selectable(
          imagePath: 'assets/images/laptop.png',
          title: 'Device',
          description: '$userName@$hostName',
          inspectorSelection: inspectorSelection,
          onClick: () => setSelected("Device"),
        ),
        if(wifiName != null)
          const AnimatedLineConnector(
            distance: 175,
            angle: 0,
            color: Colors.black38,
            spacing: 20.0,
            dotSize: 1.0,
            shift: -0.5,
          ),
        const SizedBox(
          width: 160,
          height: 0,
        ),
        Selectable(
            imagePath: 'assets/images/router.png',
            title: 'Router',
            description: wifiName ?? 'No Wi-Fi',
            inspectorSelection: inspectorSelection,
            onClick: () => setSelected("Router"),)
      ],
    );
  }
}