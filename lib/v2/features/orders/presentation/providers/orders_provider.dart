import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/order_repository.dart';
import '../../../../core/models/order_model.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository();
});

final incomingOrdersProvider =
    StateNotifierProvider<IncomingOrdersNotifier, OrdersState>((ref) {
  return IncomingOrdersNotifier(ref.read(orderRepositoryProvider));
});

final outgoingOrdersProvider =
    StateNotifierProvider<OutgoingOrdersNotifier, OrdersState>((ref) {
  return OutgoingOrdersNotifier(ref.read(orderRepositoryProvider));
});

class OrdersState {
  final List<Order> orders;
  final bool isLoading;
  final String? error;

  OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  OrdersState copyWith({
    List<Order>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class IncomingOrdersNotifier extends StateNotifier<OrdersState> {
  final OrderRepository _repository;

  IncomingOrdersNotifier(this._repository) : super(OrdersState()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getIncomingOrders();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (orders) {
        state = state.copyWith(
          orders: orders,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  Future<bool> confirmSent(String orderId) async {
    final result = await _repository.confirmSent(orderId);

    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (success) {
        loadOrders(); // Reload after confirmation
        return true;
      },
    );
  }

  Future<void> refresh() => loadOrders();
}

class OutgoingOrdersNotifier extends StateNotifier<OrdersState> {
  final OrderRepository _repository;

  OutgoingOrdersNotifier(this._repository) : super(OrdersState()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getOutgoingOrders();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (orders) {
        state = state.copyWith(
          orders: orders,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  Future<bool> confirmReceived(String orderId) async {
    final result = await _repository.confirmReceived(orderId);

    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (success) {
        loadOrders(); // Reload after confirmation
        return true;
      },
    );
  }

  Future<void> refresh() => loadOrders();
}
