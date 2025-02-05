import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wirebird/DottedWireless.dart';

import '../ConnectionButton.dart';
import '../Selectable.dart';
import '../SolidWire.dart';

class SplitTunnel extends StatelessWidget {
  final bool connected;
  final VoidCallback toggleConnection;
  final Function setSelected;
  final String? inspectorSelection;

  const SplitTunnel({
    super.key,
    required this.connected,
    required this.toggleConnection,
    required this.setSelected,
    required this.inspectorSelection,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 40,
              child: Image.asset(
                'assets/images/skip.png',
              ),
            ),
            SizedBox(
              width: screenWidth * 0.75 / 2 - 100,
            ),
            !connected ? AnimatedLineConnector(
              distance: screenWidth * 0.75 / 2 - 100,
              angle: 3.14,
              color: Colors.black38,
              spacing: 20.0,
              dotSize: 1.0,
            ) : const SizedBox.shrink(),
            SizedBox(
              height: 85,
              child: Image.asset(
                connected ? 'assets/images/path_divider_turn.png' : 'assets/images/path_divider_straight.png',
              ),
            ),
            SolidWire(width: (screenWidth * 0.75 / 2 - 70), activated: true),
            SizedBox(
              height: 20,
              child: Image.asset('assets/images/o.png'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConnectionButton(connected: connected, toggleConnection: toggleConnection),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 75.5),
              child: SizedBox(
                    width: 75,
                    height: 0,
                    child: connected ? const AnimatedLineConnector(
                                    distance: 110,
                                    angle: 1.57079,
                                    color: Colors.black38,
                                    spacing: 20.0,
                                    dotSize: 1.0,
                                  ) : const SizedBox.shrink(),
                  )// Empty widget when `connected` is false
            ),
            Selectable(
              imagePath: 'assets/images/control_center.png',
              title: 'Control Center',
              description: 'No Controls',
              inspectorSelection: inspectorSelection,
              onClick: () => setSelected("Control Center"),
            ),
          ],
        ),
      ],
    );
  }
}
