import 'product_model.dart';

class CartItem  {
  final String id;

  final String productId;

  final String title;

  final int price;

  final String image;

  final int quantity;

  final int maxQuantity;

  final String sellerId;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
    required this.maxQuantity,
    required this.sellerId,
  });

  factory CartItem.fromProduct(Product product, {int quantity = 1}) {
    return CartItem(
      id: '${product.id}_${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      title: product.title,
      price: product.amount,
      image: product.mainImage,
      quantity: quantity,
      maxQuantity: product.quantity,
      sellerId: product.userId,
    );
  }

  int get total => price * quantity;

  bool get canIncrement => quantity < maxQuantity;

  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      id: id,
      productId: productId,
      title: title,
      price: price,
      image: image,
      quantity: quantity ?? this.quantity,
      maxQuantity: maxQuantity,
      sellerId: sellerId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}

class Cart  {
  final List<CartItem> items;

  Cart({
    this.items = const [],
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  int get totalPrice => items.fold(0, (sum, item) => sum + item.total);

  String get totalFormatted =>
      '₦${totalPrice.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          )}';

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  Cart addItem(CartItem item) {
    final existingIndex =
        items.indexWhere((i) => i.productId == item.productId);

    if (existingIndex >= 0) {
      final existing = items[existingIndex];
      final newQuantity = existing.quantity + item.quantity;

      if (newQuantity <= existing.maxQuantity) {
        final updatedItems = List<CartItem>.from(items);
        updatedItems[existingIndex] = existing.copyWith(quantity: newQuantity);
        return Cart(items: updatedItems);
      }
      return this;
    } else {
      return Cart(items: [...items, item]);
    }
  }

  Cart removeItem(String productId) {
    return Cart(
      items: items.where((item) => item.productId != productId).toList(),
    );
  }

  Cart updateQuantity(String productId, int quantity) {
    final updatedItems = items.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    return Cart(items: updatedItems);
  }

  Cart clear() {
    return Cart(items: []);
  }
}
