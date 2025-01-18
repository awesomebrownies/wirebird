import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wirebird/Selectable.dart';

import '../DottedWireless.dart';

class LocalNetwork extends StatelessWidget{
    final String? wifiName;
    final String? userName;
    final String? hostName;

    const LocalNetwork({super.key,
      this.wifiName,
      this.userName,
      this.hostName,
    });

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Selectable(
          imagePath: 'assets/images/laptop.png',
          description: '$userName@$hostName',
        ),
        const AnimatedLineConnector(
          distance: 200,
          angle: 0,
          color: Colors.black38,
          spacing: 20.0,
          dotSize: 1.0,
        ),
        Selectable(imagePath: 'assets/images/router.png', description: wifiName ?? 'No Wi-Fi')
      ],
    );
  }
}