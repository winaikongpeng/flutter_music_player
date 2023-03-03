import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'core/app.dart';

void main() {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    // ignore: avoid_print
    print(notification.audioId);
    return true;
  });

  runApp(const App());
}
