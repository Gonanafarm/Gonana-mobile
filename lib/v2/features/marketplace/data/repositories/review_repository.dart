import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/review_model.dart';
import '../../../../core/utils/failures.dart';

class ReviewRepository {
  final Dio _dio = DioClient.instance.dio;

  // Get product reviews
  Future<Result<List<Review>>> getProductReviews(String productId) async {
    try {
      final response = await _dio.get('/api/products/$productId/reviews');

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(data.map((json) => Review.fromJson(json)).toList());
      } else {
        return const Left(ServerFailure(message: 'Failed to load reviews'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Submit review
  Future<Result<Review>> submitReview({
    required String productId,
    required int rating,
    required String comment,
  }) async {
    try {
      final response = await _dio.post(
        '/api/products/$productId/reviews',
        data: {
          'rating': rating,
          'comment': comment,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(Review.fromJson(response.data['data']));
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Failed to submit review'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Failed to submit'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Update review
  Future<Result<Review>> updateReview({
    required String reviewId,
    required int rating,
    required String comment,
  }) async {
    try {
      final response = await _dio.put(
        '/api/reviews/$reviewId',
        data: {
          'rating': rating,
          'comment': comment,
        },
      );

      if (response.statusCode == 200) {
        return Right(Review.fromJson(response.data['data']));
      } else {
        return const Left(ServerFailure(message: 'Failed to update review'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Failed to update'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Delete review
  Future<Result<void>> deleteReview(String reviewId) async {
    try {
      final response = await _dio.delete('/api/reviews/$reviewId');

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFailure(message: 'Failed to delete review'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Failed to delete'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get user's reviews
  Future<Result<List<Review>>> getUserReviews() async {
    try {
      final response = await _dio.get('/api/user/reviews');

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(data.map((json) => Review.fromJson(json)).toList());
      } else {
        return const Left(ServerFailure(message: 'Failed to load reviews'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}

// Review model
class Review {
  final String id;
  final String userId;
  final String userName;
  final String? userImage;
  final String productId;
  final int rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    this.userImage,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? json['user_id'] ?? '',
      userName: json['userName'] ?? json['user_name'] ?? 'User',
      userImage: json['userImage'] ?? json['user_image'],
      productId: json['productId'] ?? json['product_id'] ?? '',
      rating: json['rating'] ?? 5,
      comment: json['comment'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
