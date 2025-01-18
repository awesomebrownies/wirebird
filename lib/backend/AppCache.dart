import 'dart:io';
import 'package:flutter/widgets.dart';

class AppCache {
  static final Map<String, ImageProvider?> _iconCache = {};
  static final Map<String, String?> _appNameCache = {};

  static Future<String?> getFullName(String appName) async {
    return _appNameCache[appName.toLowerCase()] ?? '';
  }

  static void clearCache() {
    _iconCache.clear();
    _appNameCache.clear();
  }

  static Future<ImageProvider?> getIcon(String appName) async {
    appName = appName.toLowerCase();
    if (_iconCache.containsKey(appName)) {
      return _iconCache[appName];
    }

    // Find .desktop file
    final desktopResult = await Process.run('locate', ['$appName.desktop']);
    if (desktopResult.exitCode != 0 || desktopResult.stdout.toString().isEmpty) {
      _iconCache[appName] = null;
      return null;
    }

    // Get first valid desktop file
    final desktopPath = desktopResult.stdout.toString().split('\n')
        .firstWhere((path) => path.contains('/applications/'), orElse: () => '');
    if (desktopPath.isEmpty) {
      _iconCache[appName] = null;
      return null;
    }

    try {
      // Parse desktop file for icon name
      final content = await File(desktopPath).readAsString();
      final iconLine = content.split('\n')
          .firstWhere((line) => line.startsWith('Icon=') && !line.contains('/'), orElse: () => 'Icon=$appName');
      if (iconLine.isEmpty) {
        _iconCache[appName] = null;
        return null;
      }

      // Store app name if found
      final nameLine = content.split('\n')
          .firstWhere((line) => line.startsWith('Name='), orElse: () => '');
      if (nameLine.isNotEmpty) {
        _appNameCache[appName] = nameLine.split('=')[1].trim();
      }

      // Get icon path
      final iconName = iconLine.split('=')[1].trim();
      final iconResult = await Process.run('locate', [iconName]);
      if (iconResult.exitCode != 0 || iconResult.stdout.toString().isEmpty) {
        _iconCache[appName] = null;
        return null;
      }
      // Find first valid icon file
      final iconPath = iconResult.stdout.toString().split('\n')
          .firstWhere((path) =>
      (path.endsWith('$iconName.png') || path.endsWith('$iconName.svg') || path.endsWith('$iconName.xpm')) && (path.contains('/snap/') || path.contains('/opt/') || path.contains('/usr/share/')) && !path.contains('HighContrast'),
          orElse: () => '');

      if (iconPath.isNotEmpty) {
        final image = FileImage(File(iconPath));
        _iconCache[appName] = image;
        return image;
      }
    } catch (e) {
      print('Error loading icon for $appName: $e');
    }

    _iconCache[appName] = null;
    return null;
  }
}