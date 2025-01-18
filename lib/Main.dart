import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wirebird/sections/Connections.dart';
import 'package:wirebird/sections/Firewall.dart';
import 'package:wirebird/sections/Internet.dart';
import 'package:wirebird/sections/LocalNetwork.dart';
import 'package:wirebird/sections/SplitTunnel.dart';
import 'Selectable.dart';
import 'backend/NetstatMonitor.dart';
import 'Section.dart';
import 'SolidWire.dart';

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
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Section(
                  title: 'LOCAL NETWORK',
                  color: const Color.fromARGB(255, 240, 240, 240),
                  child: LocalNetwork(wifiName: _wifiName, userName: _userName, hostName: _hostName),
                ),
                Section(
                  title: 'FIREWALL',
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Firewall(),
                ),
                Section(
                  title: 'SPLIT TUNNEL',
                  color: const Color.fromARGB(255, 240, 240, 240),
                  child: SplitTunnel(connected: connected),
                ),
                Section(
                  title: 'INTERNET',
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Internet(connected: connected, toggleConnection: _toggleConnection),
                ),
                Section(
                  title: 'CONNECTIONS',
                  color: const Color.fromARGB(255, 240, 240, 240),
                  child: Connections(activeConnections: _activeConnections,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
