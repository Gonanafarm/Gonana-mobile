import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/post_model.dart';
import '../../../../core/utils/failures.dart';

class PostRepository {
  final Dio _dio = DioClient.instance.dio;

  // ==================== GET POSTS ====================

  Future<Result<List<Post>>> getPosts({int page = 1, int limit = 15}) async {
    try {
      final response = await _dio.get(
        '/api/posts',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List? ?? [];
        final posts = data.map((json) => Post.fromJson(json)).toList();
        return Right(posts);
      } else {
        return const Left(ServerFailure(message: 'Failed to load posts'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to load posts';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== GET POST BY ID ====================

  Future<Result<Post>> getPostById(String postId) async {
    try {
      final response = await _dio.get('/api/posts/$postId');

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return Right(Post.fromJson(data));
      } else {
        return const Left(ServerFailure(message: 'Failed to load post'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to load post';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== CREATE POST ====================

  Future<Result<Post>> createPost({
    required String content,
    List<String>? imagePaths,
  }) async {
    try {
      final formData = FormData.fromMap({
        'content': content,
        if (imagePaths != null)
          'images': imagePaths
              .map((path) => MultipartFile.fromFileSync(path))
              .toList(),
      });

      final response = await _dio.post('/api/posts', data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] ?? response.data;
        return Right(Post.fromJson(data));
      } else {
        final message = response.data['message'] ?? 'Failed to create post';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to create post';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== LIKE POST ====================

  Future<Result<bool>> likePost(String postId) async {
    try {
      final response = await _dio.post('/api/posts/$postId/like');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        return const Left(ServerFailure(message: 'Failed to like post'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to like post';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== UNLIKE POST ====================

  Future<Result<bool>> unlikePost(String postId) async {
    try {
      final response = await _dio.delete('/api/posts/$postId/like');

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return const Left(ServerFailure(message: 'Failed to unlike post'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to unlike post';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== GET COMMENTS ====================

  Future<Result<List<Comment>>> getComments(String postId) async {
    try {
      final response = await _dio.get('/api/posts/$postId/comments');

      if (response.statusCode == 200) {
        final data = response.data['data'] as List? ?? [];
        final comments = data.map((json) => Comment.fromJson(json)).toList();
        return Right(comments);
      } else {
        return const Left(ServerFailure(message: 'Failed to load comments'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to load comments';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== ADD COMMENT ====================

  Future<Result<Comment>> addComment(String postId, String content) async {
    try {
      final response = await _dio.post(
        '/api/posts/$postId/comments',
        data: {'content': content},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] ?? response.data;
        return Right(Comment.fromJson(data));
      } else {
        final message = response.data['message'] ?? 'Failed to add comment';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to add comment';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== DELETE POST ====================

  Future<Result<bool>> deletePost(String postId) async {
    try {
      final response = await _dio.delete('/api/posts/$postId');

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return const Left(ServerFailure(message: 'Failed to delete post'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to delete post';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
