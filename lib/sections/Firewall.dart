import 'package:flutter/cupertino.dart';

import '../Selectable.dart';
import '../SolidWire.dart';

class Firewall extends StatelessWidget {

  final Function setSelected;
  final String? inspectorSelection;

  const Firewall({super.key,
    required this.setSelected,
    required this.inspectorSelection,
  });

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
          width: screenWidth*0.75*0.5 - 56,
          activated: true,
        ),
        Selectable(
          imagePath: 'assets/images/packet_inspection.png',
          title: 'Inspection',
          description: 'Pass',
          inspectorSelection: inspectorSelection,
          onClick: () => setSelected("Inspection"),
        ),
        SolidWire(
          width: screenWidth*0.75*0.5 - 56,
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