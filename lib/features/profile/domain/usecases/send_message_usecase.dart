import 'package:sham_booking/features/profile/domain/entities/chat_message.dart';
import 'package:sham_booking/features/profile/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  SendMessageUseCase(this.repository);
  final ChatRepository repository;

  Future<String> call(String text, List<ChatMessage> history) {
    return repository.sendMessage(text, history);
  }
}
