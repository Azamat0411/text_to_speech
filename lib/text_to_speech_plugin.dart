import 'package:flutter/services.dart';

class TextToSpeechPlugin {
  static const String _channelName = 'text_to_speech';
  static const String _speak = 'speak';
  static const String _setPitch = 'set_pitch';
  static const String _setRate = 'set_rate';
  static const String _setVoice = 'set_voice';
  static const MethodChannel _channel = MethodChannel(_channelName);

  Future<void> speak(String text) async {
    await _channel.invokeMethod(_speak, text);
  }

  Future<void> setPitch(double pitch) async {
    await _channel.invokeMethod(_setPitch, pitch);
  }

  Future<void> setRate(double rate) async {
    await _channel.invokeMethod(_setRate, rate);
  }

  Future<void> setVoice(bool male) async {
    await _channel.invokeMethod(_setVoice, male);
  }
}
