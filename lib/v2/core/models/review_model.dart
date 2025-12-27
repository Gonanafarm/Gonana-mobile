class ProductReview {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String? userImage;
  final int rating; // 1-5
  final String? comment;
  final DateTime createdAt;

  ProductReview({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    this.userImage,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json['_id'] ?? json['id'] ?? '',
      productId: json['productId'] ?? '',
      userId: json['userId'] ?? json['user']?['_id'] ?? '',
      userName: json['userName'] ??
          '${json['user']?['firstName'] ?? ''} ${json['user']?['lastName'] ?? ''}'
              .trim(),
      userImage: json['userImage'] ?? json['user']?['profileImage'],
      rating: json['rating'] ?? 5,
      comment: json['comment'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'rating': rating,
      if (comment != null) 'comment': comment,
    };
  }
}
