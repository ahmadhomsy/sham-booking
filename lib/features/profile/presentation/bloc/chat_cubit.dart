import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/helpers/speech_service.dart';
import 'package:sham_booking/features/profile/domain/entities/chat_message.dart';
import 'package:sham_booking/features/profile/domain/usecases/send_message_usecase.dart';
import 'package:sham_booking/features/profile/presentation/bloc/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.sendMessageUseCase,
    required this.speechService,
  }) : super(const ChatState());
  final SendMessageUseCase sendMessageUseCase;
  final SpeechService speechService;

  Future<void> toggleListening() async {
    emit(state.copyWith(clearSpeechError: true));
    if (state.isListening) {
      await speechService.stopListening();
      emit(state.copyWith(isListening: false));
    } else {
      final available = await speechService.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            emit(state.copyWith(isListening: false));
          }
        },
        onError: (errorMsg) {
          emit(
            state.copyWith(
              isListening: false,
              speechError: 'حدث خطأ في المايكروفون: $errorMsg',
            ),
          );
        },
      );

      if (available) {
        emit(state.copyWith(isListening: true, clearRecognizedWords: true));
        await speechService.startListening(
          onResult: (words) {
            emit(state.copyWith(recognizedWords: words));
          },
        );
      } else {
        emit(
          state.copyWith(
            speechError: 'خدمة التعرف على الصوت غير متاحة حالياً',
            isListening: false,
          ),
        );
      }
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(text: text, isUser: true);

    emit(
      state.copyWith(
        messages: List.of(state.messages)..add(userMsg),
        isLoading: true,
      ),
    );

    try {
      final history = state.messages.take(state.messages.length - 1).toList();

      final aiResponseText = await sendMessageUseCase(text, history);

      final aiMsg = ChatMessage(text: aiResponseText, isUser: false);
      emit(
        state.copyWith(
          messages: List.of(state.messages)..add(aiMsg),
          isLoading: false,
        ),
      );
    } catch (e) {
      // الخطأ الحقيقي للمطور فقط
      print('Chat error: $e');

      const userFriendlyMessage = 'عذراً، لم أتمكن من معالجة رسالتك حالياً. ';

      final errorMsg = ChatMessage(
        text: userFriendlyMessage,
        isUser: false,
      );

      emit(
        state.copyWith(
          messages: List.of(state.messages)..add(errorMsg),
          isLoading: false,
          errorMessage: userFriendlyMessage,
        ),
      );
    }
  }

  void clearChat() {
    emit(const ChatState());
  }
}
