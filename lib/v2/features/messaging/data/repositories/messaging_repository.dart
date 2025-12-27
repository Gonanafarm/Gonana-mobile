import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/messaging_model.dart';
import '../../../../core/utils/failures.dart';

class MessagingRepository {
  final Dio _dio = DioClient.instance.dio;

  // Get conversations list
  Future<Result<List<ChatConversation>>> getConversations() async {
    try {
      final response = await _dio.get('/api/messages');

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(
            data.map((json) => ChatConversation.fromJson(json)).toList());
      } else {
        return const Left(
            ServerFailure(message: 'Failed to load conversations'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get messages in a conversation
  Future<Result<List<ChatMessage>>> getMessages(String conversationId) async {
    try {
      final response = await _dio.get('/api/messages/$conversationId');

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(data.map((json) => ChatMessage.fromJson(json)).toList());
      } else {
        return const Left(ServerFailure(message: 'Failed to load messages'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Send message
  Future<Result<ChatMessage>> sendMessage({
    required String recipientId,
    required String message,
    String? imageUrl,
  }) async {
    try {
      final response = await _dio.post(
        '/api/messages/send',
        data: {
          'recipientId': recipientId,
          '': message,
          if (imageUrl != null) 'imageUrl': imageUrl,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(ChatMessage.fromJson(response.data['data']));
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Failed to send'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Failed to send'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Mark message as read
  Future<Result<void>> markAsRead(String messageId) async {
    try {
      final response = await _dio.put('/api/messages/$messageId/read');

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFailure(message: 'Failed to mark as read'));
      }
    } on DioException catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'Failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Mark all messages in conversation as read
  Future<Result<void>> markConversationAsRead(String conversationId) async {
    try {
      final response = await _dio.put('/api/messages/$conversationId/read-all');

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFailure(message: 'Failed'));
      }
    } on DioException catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'Failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
