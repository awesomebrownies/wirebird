import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionButton extends StatelessWidget{
  final bool connected;
  final VoidCallback toggleConnection;

  const ConnectionButton({super.key,
    required this.connected,
    required this.toggleConnection,
  });

  @override
  Widget build(BuildContext context){
      MaterialColor color = Colors.lightGreen;
      String text = 'VPN Server';
      if (connected) {
        color = Colors.red;
        text = 'Direct Lane';
      }
      return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size(130, 50),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero,),
          ),
          onPressed: toggleConnection,
          child: Column(
            children: [
              const Text(
                'Switch track to:',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          )
      );
  }
}