// Notification model
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type; // order, wallet, system, promo
  final bool isRead;
  final String? imageUrl;
  final String? actionUrl;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.isRead = false,
    this.imageUrl,
    this.actionUrl,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? json['message'] ?? '',
      type: json['type'] ?? 'system',
      isRead: json['isRead'] ?? json['is_read'] ?? false,
      imageUrl: json['imageUrl'] ?? json['image_url'],
      actionUrl: json['actionUrl'] ?? json['action_url'],
      createdAt: json['created_at'] ??
          json['createdAt'] ??
          DateTime.now().toIso8601String(),
    );
  }
}
