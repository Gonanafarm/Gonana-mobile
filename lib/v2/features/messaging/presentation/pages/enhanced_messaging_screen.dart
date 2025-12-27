import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/messaging_model.dart';

// Enhanced Messaging with Group Chats, Media, Voice Messages
class EnhancedMessagingScreen extends ConsumerStatefulWidget {
  const EnhancedMessagingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EnhancedMessagingScreen> createState() =>
      _EnhancedMessagingScreenState();
}

class _EnhancedMessagingScreenState
    extends ConsumerState<EnhancedMessagingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: () => _createGroupChat(),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptions(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Groups'),
            Tab(text: 'Unread'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppTheme.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Conversations List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllConversations(),
                _buildGroupConversations(),
                _buildUnreadConversations(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewChat(),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildAllConversations() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 10,
      itemBuilder: (context, index) => _buildConversationCard(index),
    );
  }

  Widget _buildConversationCard(int index) {
    final isGroup = index % 4 == 0;
    final hasUnread = index % 3 == 0;
    final unreadCount = hasUnread ? (index % 5) + 1 : 0;
    final isOnline = index % 2 == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: hasUnread
            ? Border.all(
                color: AppTheme.primaryColor.withOpacity(0.3), width: 2)
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: isGroup
                  ? Colors.purple.withOpacity(0.2)
                  : AppTheme.primaryColor.withOpacity(0.2),
              child: Icon(
                isGroup ? Icons.group : Icons.person,
                color: isGroup ? Colors.purple : AppTheme.primaryColor,
                size: 28,
              ),
            ),
            if (isOnline && !isGroup)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppTheme.successColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.cardColor, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                isGroup ? 'Group Chat ${index + 1}' : 'User ${index + 1}',
                style: TextStyle(
                  fontWeight: hasUnread ? FontWeight.bold : FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              '${index + 1}m',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            if (index % 5 == 0) ...[
              const Icon(Icons.mic, size: 14, color: AppTheme.primaryColor),
              const SizedBox(width: 4),
            ],
            if (index % 6 == 0) ...[
              const Icon(Icons.image, size: 14, color: AppTheme.successColor),
              const SizedBox(width: 4),
            ],
            Expanded(
              child: Text(
                index % 5 == 0
                    ? 'Voice message'
                    : index % 6 == 0
                        ? 'Photo'
                        : 'Hey! This is a message preview...',
                style: TextStyle(
                  color:
                      hasUnread ? AppTheme.textPrimary : AppTheme.textSecondary,
                  fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: unreadCount > 0
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: () => _openChat(index, isGroup),
      ),
    ).animate().fadeIn().slideX(begin: 0.2, delay: (index * 50).ms);
  }

  Widget _buildGroupConversations() {
    return Center(child: Text('Group Chats'));
  }

  Widget _buildUnreadConversations() {
    return Center(child: Text('Unread Messages'));
  }

  void _createGroupChat() {}
  void _showOptions() {}
  void _startNewChat() {}
  void _openChat(int index, bool isGroup) {
    // Navigate to enhanced chat screen
  }
}

// Enhanced Chat Screen with Media, Voice, Reactions
class EnhancedChatScreen extends ConsumerStatefulWidget {
  final String userId;
  final String userName;
  final bool isGroup;

  const EnhancedChatScreen({
    Key? key,
    required this.userId,
    required this.userName,
    this.isGroup = false,
  }) : super(key: key);

  @override
  ConsumerState<EnhancedChatScreen> createState() => _EnhancedChatScreenState();
}

class _EnhancedChatScreenState extends ConsumerState<EnhancedChatScreen> {
  final _messageController = TextEditingController();
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
              child:
                  Icon(widget.isGroup ? Icons.group : Icons.person, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (!widget.isGroup)
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.successColor,
                      ),
                    ),
                  if (widget.isGroup)
                    Text(
                      '12 members',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: 15,
              itemBuilder: (context, index) => _buildMessageBubble(index),
            ),
          ),

          // Typing Indicator
          if (_isTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    '${widget.userName} is typing',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation(AppTheme.textSecondary),
                    ),
                  ),
                ],
              ),
            ),

          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(int index) {
    final isMine = index % 2 == 0;
    final hasImage = index % 7 == 0;
    final isVoice = index % 9 == 0;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMine ? AppTheme.primaryColor : AppTheme.cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMine ? 16 : 4),
                  bottomRight: Radius.circular(isMine ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(Icons.image,
                            size: 40, color: Colors.grey[400]),
                      ),
                    ),
                  if (isVoice)
                    Row(
                      children: [
                        Icon(
                          Icons.play_circle_filled,
                          color: isMine ? Colors.white : AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: (isMine
                                      ? Colors.white
                                      : AppTheme.primaryColor)
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '0:${12 + index}',
                          style: TextStyle(
                            color: isMine ? Colors.white : AppTheme.textPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  else if (!hasImage)
                    Text(
                      'This is message number ${index + 1}',
                      style: TextStyle(
                        color: isMine ? Colors.white : AppTheme.textPrimary,
                        fontSize: 15,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${10 + index}:${20 + index} AM',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
                if (isMine) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.done_all,
                    size: 14,
                    color: index % 3 == 0
                        ? AppTheme.primaryColor
                        : AppTheme.textSecondary,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(
          begin: isMine ? 0.2 : -0.2,
          delay: (index * 30).ms,
        );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => _showAttachmentOptions(),
            color: AppTheme.primaryColor,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: AppTheme.backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              onChanged: (value) {
                // Simulate typing indicator
              },
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _sendMessage(),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAttachmentOption(Icons.image, 'Photo', Colors.purple),
            _buildAttachmentOption(Icons.videocam, 'Video', Colors.red),
            _buildAttachmentOption(Icons.mic, 'Voice', Colors.blue),
            _buildAttachmentOption(
                Icons.insert_drive_file, 'Document', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        // Handle attachment
      },
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    // Send message logic
    _messageController.clear();
  }
}
