import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/utils/failures.dart';

class ProductRepository {
  final Dio _dio = DioClient.instance.dio;

  // ==================== GET PRODUCTS ====================

  Future<Result<List<Product>>> getProducts({
    int page = 1,
    int limit = 15,
    String type = 'product',
  }) async {
    try {
      final response = await _dio.get(
        '/api/catalog/posts',
        queryParameters: {
          'page': page,
          'limit': limit,
          'type': type,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List?;
        if (data != null) {
          final products = data.map((json) => Product.fromJson(json)).toList();
          return Right(products);
        }
        return const Right([]);
      } else {
        return const Left(ServerFailure(message: 'Failed to load products'));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(NetworkFailure());
      }

      final message = e.response?.data['message'] ?? 'Failed to load products';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== GET USER PRODUCTS ====================

  Future<Result<List<Product>>> getUserProducts({
    int page = 1,
    int limit = 15,
  }) async {
    try {
      final response = await _dio.get(
        '/api/catalog/posts/user-products',
        queryParameters: {
          'type': 'product',
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List?;
        if (data != null) {
          final products = data.map((json) => Product.fromJson(json)).toList();
          return Right(products);
        }
        return const Right([]);
      } else {
        return const Left(
            ServerFailure(message: 'Failed to load your products'));
      }
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Failed to load your products';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== GET DISCOUNTED PRODUCTS ====================

  Future<Result<List<Product>>> getDiscountedProducts({
    int page = 1,
    int limit = 15,
  }) async {
    try {
      final response = await _dio.get(
        '/api/catalog/posts/discounted-products',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List?;
        if (data != null) {
          final products = data.map((json) => Product.fromJson(json)).toList();
          return Right(products);
        }
        return const Right([]);
      } else {
        return const Left(
            ServerFailure(message: 'Failed to load discounted products'));
      }
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Failed to load discounted products';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== GET PRODUCT BY ID ====================

  Future<Result<Product>> getProductById(String id) async {
    try {
      final response = await _dio.get('/api/catalog/posts/$id');

      if (response.statusCode == 200) {
        final productData = response.data['data'];
        if (productData != null) {
          final product = Product.fromJson(productData);
          return Right(product);
        }
        return const Left(ServerFailure(message: 'Product not found'));
      } else {
        return const Left(ServerFailure(message: 'Failed to load product'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to load product';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== SEARCH PRODUCTS ====================

  Future<Result<List<Product>>> searchProducts({
    required String query,
    int page = 1,
    int limit = 15,
  }) async {
    try {
      final response = await _dio.get(
        '/api/catalog/posts',
        queryParameters: {
          'type': 'product',
          'title': query,
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List?;
        if (data != null) {
          final products = data.map((json) => Product.fromJson(json)).toList();
          return Right(products);
        }
        return const Right([]);
      } else {
        return const Left(ServerFailure(message: 'Search failed'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Search failed';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== DELETE PRODUCT ====================

  Future<Result<bool>> deleteProduct(String id) async {
    try {
      final response = await _dio.delete('/api/catalog/posts/$id');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(true);
      } else {
        final message = response.data['message'] ?? 'Failed to delete product';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to delete product';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== UPDATE PRICE ====================

  Future<Result<Product>> updatePrice({
    required String id,
    required int price,
  }) async {
    try {
      final response = await _dio.patch(
        '/api/catalog/posts/update-amount',
        data: {
          'id': id,
          'amount': price,
        },
      );

      if (response.statusCode == 200) {
        final productData = response.data['data'];
        if (productData != null) {
          final product = Product.fromJson(productData);
          return Right(product);
        }
        return const Left(ServerFailure(message: 'Failed to update price'));
      } else {
        final message = response.data['message'] ?? 'Failed to update price';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to update price';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
