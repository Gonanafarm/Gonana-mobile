import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/utils/failures.dart';

class SellerRepository {
  final Dio _dio = DioClient.instance.dio;

  // ==================== GET USER PRODUCTS ====================

  Future<Result<List<Product>>> getUserProducts({
    int page = 1,
    int limit = 20,
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
        final data = response.data['data'] as List? ?? [];
        final products = data.map((json) => Product.fromJson(json)).toList();
        return Right(products);
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

  // ==================== CREATE PRODUCT ====================

  Future<Result<Product>> createProduct({
    required String title,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<XFile> images,
    String? location,
    int? discount,
  }) async {
    try {
      // Upload images first
      final imageUrls = await _uploadImages(images);
      if (imageUrls.isEmpty) {
        return const Left(
            ServerFailure(message: 'Failed to upload product images'));
      }

      final response = await _dio.post(
        '/api/catalog/posts',
        data: {
          'type': 'product',
          'title': title,
          'description': description,
          'price': price,
          'quantity': quantity,
          'category': category,
          'images': imageUrls,
          'mainImage': imageUrls.first,
          if (location != null) 'location': location,
          if (discount != null && discount > 0) 'discount': discount,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final productData = response.data['data'];
        if (productData != null) {
          final product = Product.fromJson(productData);
          return Right(product);
        }
        return const Left(ServerFailure(message: 'Failed to create product'));
      } else {
        final message = response.data['message'] ?? 'Failed to create product';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to create product';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== UPDATE PRODUCT ====================

  Future<Result<Product>> updateProduct({
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
    try {
      final data = <String, dynamic>{'id': productId};

      // Upload new images if provided
      if (newImages != null && newImages.isNotEmpty) {
        final imageUrls = await _uploadImages(newImages);
        if (imageUrls.isNotEmpty) {
          data['images'] = imageUrls;
          data['mainImage'] = imageUrls.first;
        }
      }

      if (title != null) data['title'] = title;
      if (description != null) data['description'] = description;
      if (price != null) data['price'] = price;
      if (quantity != null) data['quantity'] = quantity;
      if (category != null) data['category'] = category;
      if (location != null) data['location'] = location;
      if (discount != null) data['discount'] = discount;

      final response = await _dio.put(
        '/api/catalog/posts/$productId',
        data: data,
      );

      if (response.statusCode == 200) {
        final productData = response.data['data'];
        if (productData != null) {
          final product = Product.fromJson(productData);
          return Right(product);
        }
        return const Left(ServerFailure(message: 'Failed to update product'));
      } else {
        final message = response.data['message'] ?? 'Failed to update product';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to update product';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== DELETE PRODUCT ====================

  Future<Result<bool>> deleteProduct(String productId) async {
    try {
      final response = await _dio.delete('/api/catalog/posts/$productId');

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
    required String productId,
    required int newPrice,
  }) async {
    try {
      final response = await _dio.patch(
        '/api/catalog/posts/update-amount',
        data: {
          'id': productId,
          'amount': newPrice,
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

  // ==================== HELPER: UPLOAD IMAGES ====================

  Future<List<String>> _uploadImages(List<XFile> images) async {
    final uploadedUrls = <String>[];

    for (final image in images) {
      try {
        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
        });

        final response = await _dio.post(
          '/api/uploads/image',
          data: formData,
        );

        if (response.statusCode == 200) {
          final imageUrl = response.data['data']?['url'] ??
              response.data['data']?['imageUrl'];
          if (imageUrl != null) {
            uploadedUrls.add(imageUrl);
          }
        }
      } catch (e) {
        // Continue with other images even if one fails
        continue;
      }
    }

    return uploadedUrls;
  }
}
