import 'package:sham_booking/features/profile/data/datasources/chat_remote_data_source.dart';
import 'package:sham_booking/features/profile/domain/entities/chat_message.dart';
import 'package:sham_booking/features/profile/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this.remoteDataSource);
  final ChatRemoteDataSource remoteDataSource;

  @override
  Future<String> sendMessage(String text, List<ChatMessage> history) async {
    try {
      return await remoteDataSource.sendMessage(text, history);
    } catch (e) {
      throw Exception('حدث خطأ أثناء الاتصال: $e');
    }
  }
}
