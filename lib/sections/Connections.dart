import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Connections extends StatelessWidget {
  final Map<String, Map<String, dynamic>>? activeConnections;

  const Connections({super.key,
    this.activeConnections,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        ) : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: activeConnections!.entries.map<Widget>((entry) {
              final appName = entry.key;
              final appData = entry.value;
              final iconProvider = appData['iconProvider'];
              final appFullName = appData['fullName'];

              return SizedBox(
                width: 150,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(iconProvider != null)
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
                        if(appFullName != '')
                          Text(
                            appFullName,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        Text(
                          '${appData['count']}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    )
                  )
                )
              );
            }).toList(),
          )
        )
      ],
    );
  }
}