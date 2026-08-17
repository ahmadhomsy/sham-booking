import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/profile/domain/entities/chat_message.dart';
import 'package:sham_booking/features/profile/presentation/bloc/chat_cubit.dart';
import 'package:sham_booking/features/profile/presentation/bloc/chat_state.dart';

class ContactAiConciergePage extends StatefulWidget {
  const ContactAiConciergePage({super.key});

  @override
  State<ContactAiConciergePage> createState() => _ContactAiConciergePageState();
}

class _ContactAiConciergePageState extends State<ContactAiConciergePage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listenWhen: (previous, current) =>
          previous.messages.length != current.messages.length ||
          previous.recognizedWords != current.recognizedWords ||
          previous.speechError != current.speechError,
      listener: (context, state) {
        _scrollToBottom();

        // تحديث حقل الإدخال تلقائياً عند التعرف على كلمات جديدة من الميكروفون
        if (state.recognizedWords.isNotEmpty) {
          _textController.text = state.recognizedWords;
          _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length),
          );
        }
        if (state.speechError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.speechError!,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.dangerRed,
            ),
          );
        }
      },
      builder: (context, state) {
        final chatCubit = context.read<ChatCubit>();
        final screenWidth = MediaQuery.of(context).size.width;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            iconTheme: const IconThemeData(
              color: AppColors.surfaceContainerLowest,
            ),
            titleSpacing: 0,
            title: const Row(
              children: [
                Icon(Icons.room_service, color: AppColors.secondaryContainer),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SHAM BOOKING',
                      style: TextStyle(
                        color: AppColors.surfaceContainerLowest,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Damascus AI Concierge',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primaryFixedDim,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: state.messages.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              final msg = state.messages[index];
                              return _buildChatBubble(msg, screenWidth * 0.75);
                            },
                          ),
                  ),
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: AppColors.goldAccent,
                      ),
                    ),
                  _buildInputArea(chatCubit, state.isListening),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.support_agent_rounded,
              size: 64,
              color: AppColors.goldAccent,
            ),
            SizedBox(height: 16),
            Text(
              'أهلاً بك في دمشق!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'كيف يمكنني مساعدتك في تخطيط رحلتك واختيار فندقك في أقدم عاصمة مأهولة؟',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage msg, double maxWidth) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          color: msg.isUser
              ? AppColors.primaryContainer
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
            bottomRight: Radius.circular(msg.isUser ? 4 : 16),
          ),
          boxShadow: msg.isUser
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
          border: msg.isUser
              ? null
              : Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.3),
                ),
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            color: msg.isUser ? Colors.white : AppColors.onSurface,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(ChatCubit chatCubit, bool isListening) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: (_) => _handleSend(chatCubit),
              style: const TextStyle(color: AppColors.onSurface),
              decoration: const InputDecoration(
                hintText: 'اسأل عن الأماكن، الفنادق، أو المطاعم في دمشق...',
                hintStyle: TextStyle(color: AppColors.outline, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          IconButton(
            onPressed: () => chatCubit.toggleListening(),
            icon: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              color: isListening ? AppColors.dangerRed : AppColors.outline,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: IconButton(
              onPressed: () => _handleSend(chatCubit),
              icon: const Icon(
                Icons.send_rounded,
                color: AppColors.secondaryContainer,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSend(ChatCubit chatCubit) async {
    if (_textController.text.trim().isEmpty) return;
    final text = _textController.text;
    _textController.clear();
    await chatCubit.sendMessage(text);
  }
}
