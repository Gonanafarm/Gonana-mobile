// Product model without Hive

class Product {
  final String id;

  final String title;

  final String body;

  final int amount;

  final int quantity;

  final double? weight;

  final List<String> images;

  final List<String> categories;

  final String userId;

  final String? userName;

  final String? userImage;

  final double? geoLat;

  final double? geoLong;

  final String? address;

  final String? deliveryCompany;

  final bool selfShipping;

  final int? usdPrice;

  final String status;

  final String createdAt;

  Product({
    required this.id,
    required this.title,
    required this.body,
    required this.amount,
    required this.quantity,
    this.weight,
    required this.images,
    required this.categories,
    required this.userId,
    this.userName,
    this.userImage,
    this.geoLat,
    this.geoLong,
    this.address,
    this.deliveryCompany,
    this.selfShipping = false,
    this.usdPrice,
    this.status = 'published',
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handle nested product object from API
    final productData = json['product'] as Map<String, dynamic>? ?? json;
    final userData = json['user'] as Map<String, dynamic>?;

    return Product(
      id: productData['_id'] ?? productData['id'] ?? '',
      title: productData['title'] ?? '',
      body: productData['body'] ?? '',
      amount: productData['amount'] ?? 0,
      quantity: productData['quantity'] ?? 0,
      weight: productData['weight']?.toDouble(),
      images: _parseImages(productData['images']),
      categories: _parseCategories(productData['categories']),
      userId:
          userData?['_id'] ?? userData?['id'] ?? productData['userId'] ?? '',
      userName: userData?['firstName'] != null && userData?['lastName'] != null
          ? '${userData!['firstName']} ${userData['lastName']}'
          : null,
      userImage: userData?['profileImage'],
      geoLat: productData['geo_lat']?.toDouble(),
      geoLong: productData['geo_long']?.toDouble(),
      address: _parseAddress(productData['address']),
      deliveryCompany: productData['delivery_company'],
      selfShipping: productData['self_shipping'] ?? false,
      usdPrice: productData['usd_price'],
      status: productData['status'] ?? 'published',
      createdAt: productData['created_at'] ??
          productData['createdAt'] ??
          DateTime.now().toIso8601String(),
    );
  }

  static List<String> _parseImages(dynamic images) {
    if (images == null) return [];
    if (images is List) {
      return images.map((e) => e.toString()).toList();
    }
    return [];
  }

  static List<String> _parseCategories(dynamic categories) {
    if (categories == null) return [];
    if (categories is String) {
      return [categories];
    }
    if (categories is List) {
      return categories.map((e) => e.toString()).toList();
    }
    return [];
  }

  static String? _parseAddress(dynamic address) {
    if (address == null) return null;
    if (address is String) return address;
    if (address is List && address.isNotEmpty) {
      final first = address[0];
      if (first is Map) {
        return first['address']?.toString();
      }
      return first.toString();
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'amount': amount,
      'quantity': quantity,
      'weight': weight,
      'images': images,
      'categories': categories,
      'userId': userId,
      'geo_lat': geoLat,
      'geo_long': geoLong,
      'address': address,
      'delivery_company': deliveryCompany,
      'self_shipping': selfShipping,
      'usd_price': usdPrice,
      'status': status,
      'created_at': createdAt,
    };
  }

  String get mainImage => images.isNotEmpty ? images[0] : '';

  String get priceFormatted => '₦${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';

  bool get hasDiscount => usdPrice != null && usdPrice! < amount;

  bool get inStock => quantity > 0;

  // Convenience getters for compatibility
  int get price => amount;
  String? get description => body.isEmpty ? null : body;
  String? get category => categories.isNotEmpty ? categories[0] : null;
  int? get discount =>
      hasDiscount ? ((amount - usdPrice!) * 100 / amount).toInt() : null;

  // Parse createdAt string to DateTime
  DateTime? get createdAtParsed => DateTime.tryParse(createdAt);
}
