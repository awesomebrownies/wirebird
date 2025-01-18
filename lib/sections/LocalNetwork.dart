import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DottedWireless.dart';

class LocalNetwork extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // selectable(
        //   'assets/images/laptop.png',
        //   '$_userName@$_hostName',
        // ),
        AnimatedLineConnector(
          distance: 200,
          angle: 0,
          color: Colors.black38,
          spacing: 20.0,
          dotSize: 1.0,
        ),
        // selectable(
        //   'assets/images/router.png',
        //   _wifiName ?? 'No Wi-Fi',
        // ),
      ],
    );
  }
}