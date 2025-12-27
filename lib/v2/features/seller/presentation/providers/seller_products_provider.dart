import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/repositories/seller_repository.dart';
import '../../../../core/models/product_model.dart';

final sellerRepositoryProvider = Provider<SellerRepository>((ref) {
  return SellerRepository();
});

final sellerProductsProvider =
    StateNotifierProvider<SellerProductsNotifier, SellerProductsState>((ref) {
  return SellerProductsNotifier(ref.read(sellerRepositoryProvider));
});

class SellerProductsState {
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMore;

  SellerProductsState({
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  SellerProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return SellerProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class SellerProductsNotifier extends StateNotifier<SellerProductsState> {
  final SellerRepository _repository;

  SellerProductsNotifier(this._repository) : super(SellerProductsState()) {
    loadProducts();
  }

  Future<void> loadProducts({bool refresh = false}) async {
    if (refresh) {
      state = SellerProductsState(isLoading: true);
    } else if (state.isLoading || !state.hasMore) {
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getUserProducts(
      page: refresh ? 1 : state.currentPage,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (newProducts) {
        final products =
            refresh ? newProducts : [...state.products, ...newProducts];

        state = state.copyWith(
          products: products,
          isLoading: false,
          currentPage: refresh ? 2 : state.currentPage + 1,
          hasMore: newProducts.length >= 20,
          error: null,
        );
      },
    );
  }

  Future<bool> createProduct({
    required String title,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<XFile> images,
    String? location,
    int? discount,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.createProduct(
      title: title,
      description: description,
      price: price,
      quantity: quantity,
      category: category,
      images: images,
      location: location,
      discount: discount,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
        return false;
      },
      (product) {
        // Add new product to the beginning of the list
        state = state.copyWith(
          products: [product, ...state.products],
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> updateProduct({
    required String productId,
    String? title,
    String? description,
    int? price,
    int? quantity,
    String? category,
    List<XFile>? newImages,
    String? location,
    int? discount,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.updateProduct(
      productId: productId,
      title: title,
      description: description,
      price: price,
      quantity: quantity,
      category: category,
      newImages: newImages,
      location: location,
      discount: discount,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
        return false;
      },
      (updatedProduct) {
        // Update product in the list
        final updatedProducts = state.products.map((p) {
          return p.id == productId ? updatedProduct : p;
        }).toList();

        state = state.copyWith(
          products: updatedProducts,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> deleteProduct(String productId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.deleteProduct(productId);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
        return false;
      },
      (_) {
        // Remove product from the list
        final updatedProducts =
            state.products.where((p) => p.id != productId).toList();

        state = state.copyWith(
          products: updatedProducts,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> updatePrice({
    required String productId,
    required int newPrice,
  }) async {
    final result = await _repository.updatePrice(
      productId: productId,
      newPrice: newPrice,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (updatedProduct) {
        // Update product in the list
        final updatedProducts = state.products.map((p) {
          return p.id == productId ? updatedProduct : p;
        }).toList();

        state = state.copyWith(
          products: updatedProducts,
          error: null,
        );
        return true;
      },
    );
  }

  Future<void> refresh() => loadProducts(refresh: true);
}
