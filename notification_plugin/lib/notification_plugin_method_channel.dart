import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'notification_plugin_platform_interface.dart';

/// An implementation of [NotificationPluginPlatform] that uses method channels.
class MethodChannelNotificationPlugin extends NotificationPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('notification_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> showNotification(String id, String title, String body) async {
    final result = await methodChannel.invokeMethod(
      'showNotification',
      {
        'id': id,
        'title': title,
        'body': body,
      },
    );
    return result ?? false;
  }
}
