import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/cart_repository.dart';
import '../../../../core/models/cart_model.dart';
import '../../../../core/models/product_model.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier(ref.read(cartRepositoryProvider));
});

class CartState {
  final Cart cart;
  final bool isLoading;
  final String? error;

  CartState({
    Cart? cart,
    this.isLoading = false,
    this.error,
  }) : cart = cart ?? Cart();

  CartState copyWith({
    Cart? cart,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  int get itemCount => cart.itemCount;
  int get totalPrice => cart.totalPrice;
  String get totalFormatted => cart.totalFormatted;
  bool get isEmpty => cart.isEmpty;
}

class CartNotifier extends StateNotifier<CartState> {
  final CartRepository _repository;

  CartNotifier(this._repository) : super(CartState()) {
    loadCart();
  }

  Future<void> loadCart() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getCart();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (cart) {
        state = state.copyWith(
          cart: cart,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  Future<bool> addToCart(Product product, {int quantity = 1}) async {
    final result = await _repository.addToCart(
      productId: product.id,
      quantity: quantity,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (cart) {
        state = state.copyWith(cart: cart, error: null);
        return true;
      },
    );
  }

  Future<bool> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      return await removeItem(productId);
    }

    final result = await _repository.updateCart(
      productId: productId,
      quantity: quantity,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (cart) {
        state = state.copyWith(cart: cart, error: null);
        return true;
      },
    );
  }

  Future<bool> removeItem(String productId) async {
    final result = await _repository.updateCart(
      productId: productId,
      quantity: 0,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (cart) {
        state = state.copyWith(cart: cart, error: null);
        return true;
      },
    );
  }

  Future<String?> placeOrder({
    required String address,
    required String paymentMethod,
    String? courierCompany,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.placeOrder(
      address: address,
      paymentMethod: paymentMethod,
      courierCompany: courierCompany,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
        return null;
      },
      (orderId) {
        state = state.copyWith(
          cart: Cart(),
          isLoading: false,
          error: null,
        );
        return orderId;
      },
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
