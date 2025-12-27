import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/cart_model.dart';
import '../../../../core/utils/failures.dart';

class CartRepository {
  final Dio _dio = DioClient.instance.dio;

  // ==================== GET CART ====================

  Future<Result<Cart>> getCart() async {
    try {
      final response = await _dio.get('/api/catalog/cart');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data != null && data['items'] != null) {
          final itemsList = data['items'] as List;
          final items = itemsList.map((json) {
            return CartItem(
              id: json['_id'] ?? json['id'] ?? '',
              productId: json['productId'] ?? '',
              title: json['title'] ?? '',
              price: json['price'] ?? 0,
              image: json['image'] ?? '',
              quantity: json['quantity'] ?? 1,
              maxQuantity: json['maxQuantity'] ?? 999,
              sellerId: json['sellerId'] ?? '',
            );
          }).toList();

          return Right(Cart(items: items));
        }
        return Right(Cart());
      } else {
        return const Left(ServerFailure(message: 'Failed to load cart'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to load cart';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== ADD TO CART ====================

  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await _dio.post(
        '/api/catalog/cart',
        data: {
          'productId': productId,
          'quantity': quantity,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return await getCart();
      } else {
        final message = response.data['message'] ?? 'Failed to add to cart';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to add to cart';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== UPDATE CART ====================

  Future<Result<Cart>> updateCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await _dio.put(
        '/api/catalog/cart',
        data: {
          'productId': productId,
          'quantity': quantity,
        },
      );

      if (response.statusCode == 200) {
        return await getCart();
      } else {
        final message = response.data['message'] ?? 'Failed to update cart';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to update cart';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== PLACE ORDER ====================

  Future<Result<String>> placeOrder({
    required String address,
    required String paymentMethod,
    String? courierCompany,
  }) async {
    try {
      final response = await _dio.post(
        '/api/catalog/cart/place-order',
        data: {
          'address': address,
          'paymentMethod': paymentMethod,
          if (courierCompany != null) 'courierCompany': courierCompany,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final orderId = response.data['data']?['orderId'] ??
            response.data['data']?['_id'] ??
            'order';
        return Right(orderId);
      } else {
        final message = response.data['message'] ?? 'Failed to place order';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to place order';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
