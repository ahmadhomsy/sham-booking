import 'package:sham_booking/features/profile/domain/entities/chat_message.dart';

class ChatState {
  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isListening = false,
    this.recognizedWords = '',
    this.speechError,
  });
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? errorMessage;
  final bool isListening;
  final String recognizedWords;
  final String? speechError;

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? errorMessage,
    bool? isListening,
    String? recognizedWords,
    String? speechError,
    bool clearRecognizedWords = false,
    bool clearSpeechError = false,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isListening: isListening ?? this.isListening,
      recognizedWords: clearRecognizedWords
          ? ''
          : (recognizedWords ?? this.recognizedWords),
      speechError: clearSpeechError ? null : (speechError ?? this.speechError),
    );
  }
}
