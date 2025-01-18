import 'package:flutter/cupertino.dart';

import '../ConnectionButton.dart';
import '../Selectable.dart';
import '../SolidWire.dart';

class SplitTunnel extends StatelessWidget{
  final bool connected;
  final VoidCallback toggleConnection;

  const SplitTunnel({super.key,
    required this.connected,
    required this.toggleConnection,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SolidWire(width: 3, height: 2, activated: true),
            SizedBox(
              height: 50,
              child: Image.asset(
                connected ? 'assets/images/path_divider_turn.png' : 'assets/images/path_divider_straight.png',
              ),
            ),
            SolidWire(width: (screenWidth*0.75/2 - 50), activated: true)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConnectionButton(connected: connected, toggleConnection: toggleConnection),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 80.0),
              child: SolidWire(width: 3, height: 100, activated: connected),
            ),
            const Selectable(
              imagePath: 'assets/images/control_center.png',
              description: 'Control Center',
            )
          ],
        )
      ],
    );
  }
}