import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

// Enhanced Notifications with Categories, Real-time, Custom Settings
class EnhancedNotificationsScreen extends ConsumerStatefulWidget {
  const EnhancedNotificationsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EnhancedNotificationsScreen> createState() =>
      _EnhancedNotificationsScreenState();
}

class _EnhancedNotificationsScreenState
    extends ConsumerState<EnhancedNotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _filterCategory = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettings(),
          ),
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () => _markAllAsRead(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Orders'),
            Tab(text: 'Payments'),
            Tab(text: 'Social'),
            Tab(text: 'System'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(5, (index) => _buildNotificationsList(index)),
      ),
    );
  }

  Widget _buildNotificationsList(int tabIndex) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 15,
        itemBuilder: (context, index) => _buildNotificationCard(index),
      ),
    );
  }

  Widget _buildNotificationCard(int index) {
    final isUnread = index % 3 == 0;
    final type = ['order', 'payment', 'social', 'system'][index % 4];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isUnread
            ? AppTheme.primaryColor.withOpacity(0.05)
            : AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isUnread
            ? Border.all(color: AppTheme.primaryColor.withOpacity(0.3))
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _getTypeColor(type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getTypeIcon(type),
            color: _getTypeColor(type),
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                _getNotificationTitle(type, index),
                style: TextStyle(
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            if (isUnread)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text(
              _getNotificationBody(type, index),
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time,
                    size: 12, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(
                  '${index + 1}h ago',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => _handleNotificationTap(type, index),
      ),
    ).animate().fadeIn().slideX(begin: 0.2, delay: (index * 50).ms);
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'order':
        return Colors.blue;
      case 'payment':
        return AppTheme.successColor;
      case 'social':
        return Colors.purple;
      case 'system':
        return Colors.orange;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_bag;
      case 'payment':
        return Icons.payment;
      case 'social':
        return Icons.favorite;
      case 'system':
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }

  String _getNotificationTitle(String type, int index) {
    switch (type) {
      case 'order':
        return 'Order #${1000 + index} Updated';
      case 'payment':
        return 'Payment Received';
      case 'social':
        return 'New Comment on Your Post';
      case 'system':
        return 'System Maintenance Alert';
      default:
        return 'Notification ${index + 1}';
    }
  }

  String _getNotificationBody(String type, int index) {
    switch (type) {
      case 'order':
        return 'Your order has been shipped and is on the way!';
      case 'payment':
        return 'You received ₦${(index + 1) * 1000} from a customer';
      case 'social':
        return 'User ${index + 1} commented on your post';
      case 'system':
        return 'Scheduled maintenance on Dec 28, 2025';
      default:
        return 'Notification content';
    }
  }

  void _handleNotificationTap(String type, int index) {
    // Navigate based on notification type
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildSettingToggle('Order Updates', true),
            _buildSettingToggle('Payment Alerts', true),
            _buildSettingToggle('Social Notifications', false),
            _buildSettingToggle('Marketing Messages', false),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingToggle(String label, bool value) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: (val) {},
      activeColor: AppTheme.primaryColor,
    );
  }

  void _markAllAsRead() {
    // Mark all notifications as read
  }
}
