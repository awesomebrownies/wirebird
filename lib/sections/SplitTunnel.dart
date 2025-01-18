import 'package:flutter/cupertino.dart';

import '../SolidWire.dart';

class SplitTunnel extends StatelessWidget{
  final bool connected;

  const SplitTunnel({super.key,
    required this.connected,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SolidWire(width: 3, height: 2, activated: true),
        SizedBox(
          height: 50,
          child: Image.asset(
            connected ? 'assets/images/path_divider_turn.png' : 'assets/images/path_divider_straight.png',
          ),
        ),
        SolidWire(width: screenWidth/2, activated: true)
      ],
    );
  }
}