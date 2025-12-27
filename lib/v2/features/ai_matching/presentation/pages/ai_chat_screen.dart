import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/services/ai_service.dart';
import '../../../marketplace/presentation/providers/products_provider.dart';

final aiMessagesProvider =
    StateNotifierProvider<AIMessagesNotifier, List<ChatMessage>>((ref) {
  return AIMessagesNotifier();
});

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class AIMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  AIMessagesNotifier() : super([]);

  void addMessage(String text, {required bool isUser}) {
    state = [
      ...state,
      ChatMessage(
        text: text,
        isUser: isUser,
        timestamp: DateTime.now(),
      ),
    ];
  }

  void clear() {
    state = [];
  }
}

class AIChatScreen extends ConsumerStatefulWidget {
  const AIChatScreen({super.key});

  @override
  ConsumerState<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends ConsumerState<AIChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();

    // Initialize AI service
    // Environment variable or hardcoded key
    const apiKey = String.fromEnvironment(
      'GEMINI_API_KEY',
      defaultValue: 'YOUR_GEMINI_API_KEY_HERE',
    );

    AIService.instance.initialize(apiKey);

    // Welcome message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendWelcomeMessage();
    });
  }

  void _sendWelcomeMessage() {
    final apiKeyError = AIService.instance.validateApiKey();

    if (apiKeyError != null) {
      // AI not available - show fallback message
      ref.read(aiMessagesProvider.notifier).addMessage(
            '👋 Hello! I\'m your shopping assistant (currently in offline mode).\n\n'
            'I can still help you find products using keyword search! Try asking about rice, tomatoes, or any other agricultural products.',
            isUser: false,
          );
    } else {
      // AI available
      ref.read(aiMessagesProvider.notifier).addMessage(
            '👋 Hi! I\'m your AI shopping assistant powered by Gemini.\n\n'
            'Ask me anything! Try:\n'
            '• "Find fresh tomatoes"\n'
            '• "Show me affordable grains"\n'
            '• "What rice varieties do you have?"',
            isUser: false,
          );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    // Add user message
    ref.read(aiMessagesProvider.notifier).addMessage(message, isUser: true);
    _messageController.clear();

    // Scroll to bottom
    _scrollToBottom();

    setState(() => _isTyping = true);

    // Get AI response
    final products = ref.read(productsProvider).products;

    String response;
    try {
      response = await AIService.instance.chat(
        message,
        products: products.isNotEmpty ? products : null,
      );
    } catch (e) {
      response = 'Sorry, I encountered an error. Please try again!';
    }

    setState(() => _isTyping = false);

    // Add AI response
    if (mounted) {
      ref.read(aiMessagesProvider.notifier).addMessage(response, isUser: false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(aiMessagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.smart_toy,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Assistant',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  AIService.instance.isInitialized ? 'Online' : 'Offline Mode',
                  style: TextStyle(
                    fontSize: 11,
                    color: AIService.instance.isInitialized
                        ? AppColors.success
                        : Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          if (messages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'New conversation',
              onPressed: () {
                ref.read(aiMessagesProvider.notifier).clear();
                _sendWelcomeMessage();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // AI Status Banner (if offline)
          if (!AIService.instance.isInitialized)
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              color: Colors.orange.withOpacity(0.1),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.orange[700]),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'AI features limited. Add Gemini API key for full experience.',
                      style: TextStyle(fontSize: 11, color: Colors.orange[700]),
                    ),
                  ),
                ],
              ),
            ),

          // Messages
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Start a conversation',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 300.ms),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= messages.length) {
                        return _buildTypingIndicator();
                      }

                      final message = messages[index];
                      return _buildMessageBubble(message);
                    },
                  ),
          ),

          // Quick suggestions
          if (messages.length <= 1)
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildQuickReply('Find rice'),
                  const SizedBox(width: AppSpacing.xs),
                  _buildQuickReply('Show vegetables'),
                  const SizedBox(width: AppSpacing.xs),
                  _buildQuickReply('Affordable grains'),
                ],
              ),
            ),

          // Input
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.isDarkMode ? AppColors.surface : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Ask me anything...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      enabled: !_isTyping,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton.filled(
                    onPressed: _isTyping ? null : _sendMessage,
                    icon: _isTyping
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppColors.primary.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReply(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        _messageController.text = text;
        _focusNode.requestFocus();
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: message.isUser
              ? AppColors.primary
              : (context.isDarkMode
                  ? AppColors.surfaceLight
                  : Colors.grey[200]),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 10,
                color: message.isUser
                    ? Colors.white.withOpacity(0.7)
                    : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 200.ms).slideX(
          begin: message.isUser ? 0.2 : -0.2,
          end: 0,
        );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.surfaceLight : Colors.grey[200],
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(0),
            const SizedBox(width: 4),
            _buildDot(1),
            const SizedBox(width: 4),
            _buildDot(2),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .fadeIn(
          delay: Duration(milliseconds: index * 200),
          duration: 600.ms,
        )
        .then()
        .fadeOut(duration: 600.ms);
  }
}
