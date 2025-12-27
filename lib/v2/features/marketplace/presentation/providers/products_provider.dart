import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/product_repository.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/utils/failures.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  return ProductsNotifier(ref.read(productRepositoryProvider));
});

final discountedProductsProvider =
    StateNotifierProvider<DiscountedProductsNotifier, ProductsState>((ref) {
  return DiscountedProductsNotifier(ref.read(productRepositoryProvider));
});

class ProductsState {
  final List<Product> products;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;
  final bool hasMore;

  ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  ProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductRepository _repository;

  ProductsNotifier(this._repository) : super(ProductsState()) {
    loadProducts();
  }

  Future<void> loadProducts({bool refresh = false}) async {
    if (refresh) {
      state = ProductsState(isLoading: true);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    final result = await _repository.getProducts(page: 1);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (products) {
        state = state.copyWith(
          products: products,
          isLoading: false,
          error: null,
          currentPage: 1,
          hasMore: products.length >= 15,
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final result = await _repository.getProducts(page: nextPage);

    result.fold(
      (failure) {
        state = state.copyWith(isLoadingMore: false);
      },
      (newProducts) {
        state = state.copyWith(
          products: [...state.products, ...newProducts],
          isLoadingMore: false,
          currentPage: nextPage,
          hasMore: newProducts.length >= 15,
        );
      },
    );
  }

  Future<void> refresh() => loadProducts(refresh: true);
}

class DiscountedProductsNotifier extends StateNotifier<ProductsState> {
  final ProductRepository _repository;

  DiscountedProductsNotifier(this._repository) : super(ProductsState()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getDiscountedProducts(page: 1);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (products) {
        state = state.copyWith(
          products: products,
          isLoading: false,
          error: null,
          currentPage: 1,
          hasMore: products.length >= 15,
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final result = await _repository.getDiscountedProducts(page: nextPage);

    result.fold(
      (failure) {
        state = state.copyWith(isLoadingMore: false);
      },
      (newProducts) {
        state = state.copyWith(
          products: [...state.products, ...newProducts],
          isLoadingMore: false,
          currentPage: nextPage,
          hasMore: newProducts.length >= 15,
        );
      },
    );
  }
}
