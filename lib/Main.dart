import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'AnimatedLineConnector.dart';
import 'NetstatMonitor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wirebird',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Network Diagram'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool connected = false;

  final NetworkInfo _networkInfo = NetworkInfo();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  String? _wifiName;
  Map<String, Map<String, dynamic>>? _activeConnections;
  final monitor = NetstatMonitor();

  String? _userName;
  String? _hostName;

  @override
  void initState() {
    super.initState();
    _fetchWifiName();
    _updateActiveConnections();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      _updateActiveConnections();
    });

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi) {
        _fetchWifiName();
      } else {
        setState(() {
          _wifiName = null;
        });
      }
    });

    _retrieveSystemInfo();
  }

  void _toggleConnection() {
    setState(() {
      connected = !connected;
    });
  }


  Future<void> _retrieveSystemInfo() async {
    try {
      final userResult = await Process.run('whoami', []);
      final hostResult = await Process.run('hostname', []);
      if (userResult.exitCode == 0 && hostResult.exitCode == 0) {
        setState(() {
          _userName = userResult.stdout.toString().trim();
          _hostName = hostResult.stdout.toString().trim();
        });
      }
    } catch (e) {}
  }

  Future<void> _fetchWifiName() async {
    try {
      final wifiName = await _networkInfo.getWifiName();
      setState(() {
        _wifiName = wifiName;
      });
    } catch (e) {
      setState(() {
        _wifiName = 'Error fetching Wi-Fi name';
      });
    }
  }

  Future<void> _updateActiveConnections() async {
    try {
      final connections = await monitor.fetchEstablishedConnections();
      if (mounted) {
        setState(() {
          _activeConnections = connections;
        });
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth - (screenWidth * 2 / 5) + 110; // Width of the grid content

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: contentWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('LOCAL NETWORK'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectable(
                    'assets/images/laptop.png',
                    '$_userName@$_hostName',
                  ),
                  const AnimatedLineConnector(
                    distance: 200,
                    angle: 0,
                    color: Colors.black38,
                    spacing: 20.0,
                    dotSize: 1.0,
                  ),
                  selectable(
                    'assets/images/router.png',
                    _wifiName ?? 'No Wi-Fi',
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('FIREWALL'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    child: Image.asset('assets/images/o.png'),
                  ),
                  line(screenWidth / 2 - screenWidth / 5, 3, true),
                  selectable(
                    'assets/images/packet_inspection.png',
                    'Inspection',
                  ),
                  line(screenWidth / 2 - screenWidth / 5, 3, true),
                  SizedBox(
                    height: 20,
                    child: Image.asset('assets/images/x.png'),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('INTERNET'),
              ),
              Center(
                child: Column(
                  children: [
                    line(3, 6, connected),
                    connectionButton(),
                    line(3, 50, connected),
                    selectable('assets/images/server_rack.png', 'Not Selected'),
                    line(3, 50, connected),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('CONNECTIONS'),
              ),
              line(contentWidth, 3, true),
              Expanded(
                child: _activeConnections == null
                    ? const Center(
                    child: Column(
                      children: <Widget>[
                        Text("No active connections found"),
                        CircularProgressIndicator(
                          strokeWidth: 1.0,
                        )
                      ],
                    ))
                    : GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: _activeConnections!.length,
                  itemBuilder: (context, index) {
                    final entry = _activeConnections!.entries.elementAt(index);
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox line(double width, double height, bool activated) {
    Color color = Colors.black12;
    if (activated) {
      color = Colors.black38;
    }

    return SizedBox(
      width: width,
      child: Divider(
        height: height,
        thickness: height,
        color: color,
      ),
    );
  }

  TextButton connectionButton() {
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
        onPressed: _toggleConnection,
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
        ));
  }

  Column selectable(String imagePath, String description) {
    return Column(
      children: [
        SizedBox(height: 70, child: Image.asset(imagePath)),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
