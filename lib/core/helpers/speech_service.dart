import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<bool> initialize({
    required void Function(String) onStatus,
    required void Function(String) onError,
  }) async {
    try {
      return await _speech.initialize(
        onStatus: onStatus,
        onError: (errorNotification) => onError(errorNotification.errorMsg),
      );
    } on Object catch (e) {
      debugPrint('Speech initialization failed: $e');
      return false;
    }
  }

  Future<void> startListening({
    required void Function(String) onResult,
    String localeId = 'ar-SA', // العربية كافتراضي
  }) async {
    await _speech.listen(
      onResult: (result) {
        /* ... */
      },
      listenOptions: stt.SpeechListenOptions(
        localeId: 'en_US',
      ),
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }
}
