import 'dart:async';
import 'dart:io';

import 'package:wirebird/backend/AppCache.dart';

class NetstatMonitor {
  // Store the previous connections
  List<String> previousConnections = [];

  Future<Map<String, Map<String, dynamic>>> fetchEstablishedConnections() async {
    try {
      final result = await Process.run('netstat', ['-tupn']);

      if (result.exitCode == 0) {
        final lines = result.stdout.toString().split('\n').where((line) => line.contains('ESTABLISHED')).toList();
        final Map<String, Map<String, dynamic>> map = {};

        for (var line in lines) {
          int appStartIndex = line.indexOf('/');
          if (appStartIndex != -1) {
            String app = line.substring(appStartIndex + 1).split(' ')[0];

            if (!map.containsKey(app)) {
              // Find icon path for the application
              final icon = await AppCache.getIcon(app);
              final fullName = await AppCache.getFullName(app);

              map[app] = {
                'fullName': fullName,
                'count': 1,
                'iconProvider': icon,
                'map': {},
              };

              final fields = line.split(" ").where((word) => word.isNotEmpty).toList();

              map[app]!['map'][fields[3]] = fields;
            } else {
              map[app]!['count'] = map[app]!['count'] + 1;
              //setup using foreign address as the key to the map
              //protocol, local address, foreign address
              final fields = line.split(" ").where((word) => word.isNotEmpty).toList();

              map[app]!['map'][fields[3]] = fields;
            }
          }
        }

        return map;
      } else {
        print('Error running netstat: ${result.stderr}');
        return {};
      }
    } catch (e) {
      print('Error!: $e');
      return {};
    }
  }
}