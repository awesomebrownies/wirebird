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
      String text = 'Proxy Server';
      if (connected) {
        color = Colors.red;
        text = 'Direct Lane';
      }
      return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size(150, 50),
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