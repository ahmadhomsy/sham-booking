import 'package:sham_booking/features/profile/domain/entities/chat_message.dart';

abstract class ChatRepository {
  Future<String> sendMessage(String text, List<ChatMessage> history);
}
