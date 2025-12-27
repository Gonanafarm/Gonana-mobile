import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/notification_model.dart';
import '../../../../core/utils/failures.dart';

class NotificationRepository {
  final Dio _dio = DioClient.instance.dio;

  // ==================== GET NOTIFICATIONS ====================

  Future<Result<List<NotificationModel>>> getNotifications() async {
    try {
      final response = await _dio.get('/api/notification');

      if (response.statusCode == 200) {
        final data = response.data['data'] as List? ?? [];
        final notifications =
            data.map((json) => NotificationModel.fromJson(json)).toList();
        return Right(notifications);
      } else {
        return const Left(
            ServerFailure(message: 'Failed to load notifications'));
      }
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Failed to load notifications';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== MARK AS READ ====================

  Future<Result<bool>> markAsRead(String notificationId) async {
    try {
      final response = await _dio.post(
        '/api/notification/mark-read',
        data: {'notificationId': notificationId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        return const Left(ServerFailure(message: 'Failed to mark as read'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to mark as read';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== MARK ALL AS READ ====================

  Future<Result<bool>> markAllAsRead() async {
    try {
      final response = await _dio.post('/api/notification/mark-all-read');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        return const Left(ServerFailure(message: 'Failed to mark all as read'));
      }
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Failed to mark all as read';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
