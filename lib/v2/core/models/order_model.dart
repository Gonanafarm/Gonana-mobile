// Order model without Hive

class Order  {
  final String id;

  final List<OrderItem> items;

  final String status; // pending, confirmed, in_transit, delivered, cancelled

  final int totalAmount;

  final String buyerId;

  final String? buyerName;

  final String sellerId;

  final String? sellerName;

  final String deliveryAddress;

  final String? courierCompany;

  final String createdAt;

  final String? updatedAt;

  Order({
    required this.id,
    required this.items,
    required this.status,
    required this.totalAmount,
    required this.buyerId,
    this.buyerName,
    required this.sellerId,
    this.sellerName,
    required this.deliveryAddress,
    this.courierCompany,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isPending => status.toLowerCase() == 'pending';
  bool get isConfirmed => status.toLowerCase() == 'confirmed';
  bool get isInTransit => status.toLowerCase() == 'in_transit';
  bool get isDelivered => status.toLowerCase() == 'delivered';
  bool get isCancelled => status.toLowerCase() == 'cancelled';

  String get totalFormatted =>
      '₦${totalAmount.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          )}';

  String get statusText {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'confirmed':
        return 'Confirmed';
      case 'in_transit':
        return 'In Transit';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List? ?? [];

    return Order(
      id: json['_id'] ?? json['id'] ?? '',
      items: itemsList.map((item) => OrderItem.fromJson(item)).toList(),
      status: json['status'] ?? 'pending',
      totalAmount: json['totalAmount'] ?? json['total_amount'] ?? 0,
      buyerId: json['buyerId'] ?? json['buyer_id'] ?? '',
      buyerName: json['buyerName'] ?? json['buyer_name'],
      sellerId: json['sellerId'] ?? json['seller_id'] ?? '',
      sellerName: json['sellerName'] ?? json['seller_name'],
      deliveryAddress:
          json['deliveryAddress'] ?? json['delivery_address'] ?? '',
      courierCompany: json['courierCompany'] ?? json['courier_company'],
      createdAt: json['created_at'] ??
          json['createdAt'] ??
          DateTime.now().toIso8601String(),
      updatedAt: json['updated_at'] ?? json['updatedAt'],
    );
  }
}

class OrderItem  {
  final String productId;

  final String title;

  final int price;

  final int quantity;

  final String? image;

  OrderItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    this.image,
  });

  int get total => price * quantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] ?? json['product_id'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 1,
      image: json['image'],
    );
  }
}
