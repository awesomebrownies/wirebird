import 'package:flutter/cupertino.dart';

import '../Selectable.dart';
import '../SolidWire.dart';

class Firewall extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
          child: Image.asset('assets/images/o.png'),
        ),
        SolidWire(
          width: screenWidth*0.75*0.5 - 80,
          activated: true,
        ),
        const Selectable(
          imagePath: 'assets/images/packet_inspection.png',
          description: 'Inspection',
        ),
        SolidWire(
          width: screenWidth*0.75*0.5 - 80,
          activated: true,
        ),
        SizedBox(
          height: 20,
          child: Image.asset('assets/images/x.png'),
        ),
      ],
    );
  }
}