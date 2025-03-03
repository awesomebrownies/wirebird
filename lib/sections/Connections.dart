import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Connections extends StatefulWidget {
  final Map<String, Map<String, dynamic>>? activeConnections;

  const Connections({super.key, this.activeConnections});

  @override
  _ConnectionsState createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
  List<bool> _isExpanded = [];
  List<String> prevConnectionKeys = [];

  @override
  void initState() {
    super.initState();
    _initializeExpansionState();
  }

  @override
  void didUpdateWidget(covariant Connections oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeConnections?.length != oldWidget.activeConnections?.length) {
      _initializeExpansionState();
    }
  }

  void _initializeExpansionState() {
    setState(() {
      final connectionKeys = widget.activeConnections?.keys.toList() ?? [];

      List<bool> newIsExpanded = [];


      //compare prevactiveconnections to new active connections
      //loop prevactiveconnections until something changes
      //determine if it is an addition or a removal
      //  addition: make the new bool list value false, then shift list index back
      //  subtraction: skip setting bool value, possibly add 1 to index?
      int shift = 0;
      for (int i = 0; i < connectionKeys.length; i++) {
        if (i < prevConnectionKeys.length && prevConnectionKeys[i] == connectionKeys[i]) {
          if (i + shift < _isExpanded.length) {
            newIsExpanded.add(_isExpanded[i + shift]);
          } else {
            newIsExpanded.add(false);
          }
          continue;
        }
        if (i + 1 < connectionKeys.length && i < prevConnectionKeys.length && prevConnectionKeys[i] == connectionKeys[i + 1]) {
          newIsExpanded.add(false);
          shift++;
        } else {
          newIsExpanded.add(false);
          shift--;
        }
      }

      prevConnectionKeys = List.from(connectionKeys);
      _isExpanded = newIsExpanded;
    });
  }


  @override
  Widget build(BuildContext context) {
    final activeConnections = widget.activeConnections ?? {};
    final connectionKeys = activeConnections.keys.toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text("Port"),
        const Text("Application"),
        // const Text("System"),
        // const Text("Unix Domain Socket"),
        activeConnections.isEmpty
            ? const Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(32.0),
                child: Text("Looking for active connections..."),
              ),
            ],
          ),
        )
            : Align(
              alignment: Alignment.topLeft,
              child: ExpansionPanelList(
                elevation: 0,
                expandedHeaderPadding: const EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded[index] = isExpanded;
                  });
                },
                children: connectionKeys.asMap().entries.map<ExpansionPanel>((entry) {
                  final index = entry.key;
                  final appName = entry.value;
                  final appData = activeConnections[appName]!;
                  final iconProvider = appData['iconProvider'];
                  final appFullName = appData['fullName'];

                  return ExpansionPanel(
                    canTapOnHeader: true,
                    isExpanded: _isExpanded[index],
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        leading: iconProvider != null
                            ? Image(
                          image: iconProvider,
                          height: 24,
                          width: 24,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.question_answer, size: 24),
                        )
                            : const Icon(Icons.settings, size: 29, color: Color.fromARGB(255, 60, 60, 60)),
                        title: Text(
                          "($appName) $appFullName",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          '${appData['count']} connections',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                    body: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Expanded Content Here")
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
      ],
    );
  }
}
