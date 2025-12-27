import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/failures.dart';

class AuthRepository {
  final Dio _dio = DioClient.instance.dio;
  final StorageService _storage = StorageService.instance;

  // ==================== LOGIN ====================

  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        // Save token
        final token = data['token'] as String?;
        if (token != null) {
          await _storage.saveToken(token);
        }

        // Save user
        final userData = data['user'] as Map<String, dynamic>?;
        if (userData != null) {
          final user = User(
            id: userData['id'] ?? userData['_id'] ?? '',
            firstName: userData['firstName'] ?? '',
            lastName: userData['lastName'] ?? '',
            email: userData['email'] ?? '',
            phone: userData['phone'],
            profileImage: userData['profileImage'],
            address: userData['address'],
            emailVerified: userData['emailVerified'] ?? false,
            phoneVerified: userData['phoneVerified'] ?? false,
            hasPasscode: userData['hasPasscode'] ?? false,
            registrationStage: userData['registrationStage'] ?? 5,
          );
          await _storage.saveUser(user);
          return Right(user);
        }

        return const Left(
            ServerFailure(message: 'Invalid response from server'));
      } else {
        final message = response.data['message'] ?? 'Login failed';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(NetworkFailure());
      }

      final message =
          e.response?.data['message'] ?? e.message ?? 'Login failed';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== SIGN UP ====================

  Future<Result<User>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/activate',
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;

        // Save token
        final token = data['token'] as String?;
        if (token != null) {
          await _storage.saveToken(token);
        }

        // Save user
        final userData = data['user'] as Map<String, dynamic>?;
        if (userData != null) {
          final user = User(
            id: userData['id'] ?? userData['_id'] ?? '',
            firstName: userData['firstName'] ?? firstName,
            lastName: userData['lastName'] ?? lastName,
            email: userData['email'] ?? email,
            phone: userData['phone'] ?? phone,
            registrationStage: userData['registrationStage'] ?? 2,
          );
          await _storage.saveUser(user);
          await _storage.setRegistrationStage(user.registrationStage);
          return Right(user);
        }

        return const Left(
            ServerFailure(message: 'Invalid response from server'));
      } else {
        final message = response.data['message'] ?? 'Sign up failed';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(NetworkFailure());
      }

      final message =
          e.response?.data['message'] ?? e.message ?? 'Sign up failed';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== VERIFY OTP ====================

  Future<Result<bool>> verifyOtp({
    required String otp,
    String? email,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/verify-otp',
        data: {
          'otp': otp,
          if (email != null) 'email': email,
        },
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        final message = response.data['message'] ?? 'OTP verification failed';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'OTP verification failed';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== GET CURRENT USER ====================

  Future<Result<User>> getCurrentUser() async {
    try {
      final response = await _dio.get('/api/auth/me');

      if (response.statusCode == 200) {
        final userData = response.data['user'] as Map<String, dynamic>?;
        if (userData != null) {
          final user = User(
            id: userData['id'] ?? userData['_id'] ?? '',
            firstName: userData['firstName'] ?? '',
            lastName: userData['lastName'] ?? '',
            email: userData['email'] ?? '',
            phone: userData['phone'],
            profileImage: userData['profileImage'],
            address: userData['address'],
            emailVerified: userData['emailVerified'] ?? false,
            phoneVerified: userData['phoneVerified'] ?? false,
            hasPasscode: userData['hasPasscode'] ?? false,
            registrationStage: userData['registrationStage'] ?? 5,
          );
          await _storage.saveUser(user);
          return Right(user);
        }
        return const Left(
            ServerFailure(message: 'Invalid response from server'));
      } else {
        return const Left(ServerFailure(message: 'Failed to get user'));
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to get user';
      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ==================== LOGOUT ====================

  Future<void> logout() async {
    await _storage.clearAll();
  }

  // ==================== CHECK AUTH STATUS ====================

  bool get isAuthenticated => _storage.hasToken && _storage.hasUser;

  User? get currentUser => _storage.getUser();
}
