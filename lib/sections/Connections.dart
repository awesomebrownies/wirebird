import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../SolidWire.dart';

class Connections extends StatelessWidget {
  Map<String, Map<String, dynamic>>? activeConnections;

  Connections({super.key,
    this.activeConnections,
  });

  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth - (screenWidth * 2 / 5) + 110;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SolidWire(width: contentWidth, activated: true),
        activeConnections == null
            ? const Center(
          child: Column(
            children: <Widget>[
              Text("No active connections found"),
              CircularProgressIndicator(
                strokeWidth: 1.0,
              )
            ],
          ),
        )
            : GridView.builder(
          physics:
          const NeverScrollableScrollPhysics(), // Ensures GridView doesn't scroll independently
          shrinkWrap: true,
          gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: activeConnections!.length,
          itemBuilder: (context, index) {
            final entry = activeConnections!.entries.elementAt(index);
            final appName = entry.key;
            final appData = entry.value;
            final iconProvider = appData['iconProvider'];
            final appFullName = appData['fullName'];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (iconProvider != null)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image(
                          image: iconProvider,
                          height: 48,
                          width: 48,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.question_answer, size: 48),
                        ),
                      )
                    else
                      const Icon(Icons.settings, size: 48),
                    Text(
                      appName,
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                    if (appFullName != '')
                      Text(
                        appFullName,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    Text(
                      '${appData['count']}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}