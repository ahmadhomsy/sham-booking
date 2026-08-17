import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sham_booking/features/profile/domain/entities/chat_message.dart';

abstract class ChatRemoteDataSource {
  Future<String> sendMessage(String text, List<ChatMessage> history);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl({required String apiKey})
    : _model = GenerativeModel(
        model: 'gemini-3.6-flash',
        apiKey: apiKey,
        systemInstruction: Content.system('''
أنت المساعد الذكي "Sham Booking AI Concierge" لتطبيق "Sham Booking".
مهمتك الأساسية هي مساعدة المستخدمين في تنظيم رحلات سياحية داخل مدينة "دمشق" السورية.
1. اقتراح أفضل الأماكن السياحية والتراثية في دمشق (مثل: الجامع الأموي، سوق الحميدية، قصر العظم، التكية السليمانية، جبل قاسيون، وأزقة دمشق القديمة).
2. ترشيح فنادق في دمشق تناسب مختلف الميزانيات (مثل فنادق دمشق القديمة كـ "بيت الوالي"، "فندق تاليسمان"، أو فنادق حديثة مثل "فندق الشام" و "الداما روز").
3. الإجابة بلباقة، احترافية، وود على استفسارات المستخدمين، وتنظيم مسارات رحلات يومية داخل دمشق إذا طُلب منك ذلك.
4. التحدث باللغة التي يفضلها المستخدم.
'''),
      );
  final GenerativeModel _model;

  @override
  Future<String> sendMessage(String text, List<ChatMessage> history) async {
    final chatHistory = history.map((m) {
      return m.isUser
          ? Content.text(m.text)
          : Content.model([TextPart(m.text)]);
    }).toList();

    final chat = _model.startChat(history: chatHistory);
    final response = await chat.sendMessage(Content.text(text));

    return response.text ?? 'عذراً، لم أتمكن من معالجة طلبك حالياً.';
  }
}
