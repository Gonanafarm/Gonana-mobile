// Post model
class Post {
  final String id;
  final String userId;
  final String? authorName;
  final String? authorImage;
  final String content;
  final List<String> images;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final String createdAt;

  Post({
    required this.id,
    required this.userId,
    this.authorName,
    this.authorImage,
    required this.content,
    this.images = const [],
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLiked = false,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final imagesList = json['images'] as List? ?? [];

    return Post(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? json['user_id'] ?? '',
      authorName: json['authorName'] ?? json['author_name'],
      authorImage: json['authorImage'] ?? json['author_image'],
      content: json['content'] ?? '',
      images: imagesList.map((e) => e.toString()).toList(),
      likesCount: json['likesCount'] ?? json['likes_count'] ?? 0,
      commentsCount: json['commentsCount'] ?? json['comments_count'] ?? 0,
      isLiked: json['isLiked'] ?? json['is_liked'] ?? false,
      createdAt: json['created_at'] ??
          json['createdAt'] ??
          DateTime.now().toIso8601String(),
    );
  }
}

// Comment model
class Comment {
  final String id;
  final String postId;
  final String userId;
  final String? authorName;
  final String? authorImage;
  final String content;
  final String createdAt;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    this.authorName,
    this.authorImage,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] ?? json['id'] ?? '',
      postId: json['postId'] ?? json['post_id'] ?? '',
      userId: json['userId'] ?? json['user_id'] ?? '',
      authorName: json['authorName'] ?? json['author_name'],
      authorImage: json['authorImage'] ?? json['author_image'],
      content: json['content'] ?? '',
      createdAt: json['created_at'] ??
          json['createdAt'] ??
          DateTime.now().toIso8601String(),
    );
  }
}
