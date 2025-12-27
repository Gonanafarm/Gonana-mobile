import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/order_model.dart' as models;
import '../../../../core/utils/failures.dart';

class OrderRepository {
  final Dio _dio = DioClient.instance.dio;

  // ==================== GET INCOMING ORDERS ====================

  Future<Result<List<models.Order>>> getIncomingOrders() async {
    try {
      final response = await _dio.get('/api/catalog/orders/incoming');

      if (response.statusCode == 200) {
        final data = response.data['data'] as List? ?? [];
        final orders = data.map((json) => models.Order.fromJson(json)).toList();
        return Right(orders);
      } else {
        return const Left(
            ServerFailure(message: 'Failed to load incoming orders'));
      }
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Failed to load incoming orders';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== GET OUTGOING ORDERS ====================

  Future<Result<List<models.Order>>> getOutgoingOrders() async {
    try {
      final response = await _dio.get('/api/catalog/orders/outgoing');

      if (response.statusCode == 200) {
        final data = response.data['data'] as List? ?? [];
        final orders = data.map((json) => models.Order.fromJson(json)).toList();
        return Right(orders);
      } else {
        return const Left(
            ServerFailure(message: 'Failed to load outgoing orders'));
      }
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Failed to load outgoing orders';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== CONFIRM SENT ====================

  Future<Result<bool>> confirmSent(String orderId) async {
    try {
      final response = await _dio.post(
        '/api/catalog/orders/confirm-sent',
        data: {'orderId': orderId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        final message =
            response.data['message'] ?? 'Failed to confirm order sent';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Failed to confirm order sent';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== CONFIRM RECEIVED ====================

  Future<Result<bool>> confirmReceived(String orderId) async {
    try {
      final response = await _dio.post(
        '/api/catalog/orders/confirm-received',
        data: {'orderId': orderId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        final message =
            response.data['message'] ?? 'Failed to confirm order received';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Failed to confirm order received';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
