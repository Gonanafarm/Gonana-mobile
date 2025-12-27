import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/savings_model.dart';
import '../../../../core/utils/failures.dart';

class SavingsRepository {
  final Dio _dio = DioClient.instance.dio;

  // Create savings account
  Future<Result<SavingsAccount>> createSavings({
    required String name,
    required int targetAmount,
    required DateTime targetDate,
    required double interestRate,
  }) async {
    try {
      final response = await _dio.post(
        '/api/savings/create',
        data: {
          'name': name,
          'targetAmount': targetAmount,
          'targetDate': targetDate.toIso8601String(),
          'interestRate': interestRate,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(SavingsAccount.fromJson(response.data['data']));
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Failed to create savings'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Failed to create savings'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get all savings accounts
  Future<Result<List<SavingsAccount>>> getSavingsAccounts() async {
    try {
      final response = await _dio.get('/api/savings');

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(
            data.map((json) => SavingsAccount.fromJson(json)).toList());
      } else {
        return const Left(ServerFailure(message: 'Failed to load savings'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get single savings account
  Future<Result<SavingsAccount>> getSavingsById(String id) async {
    try {
      final response = await _dio.get('/api/savings/$id');

      if (response.statusCode == 200) {
        return Right(SavingsAccount.fromJson(response.data['data']));
      } else {
        return const Left(ServerFailure(message: 'Failed to load savings'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Deposit to savings
  Future<Result<void>> depositToSavings({
    required String savingsId,
    required int amount,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        '/api/savings/$savingsId/deposit',
        data: {
          'amount': amount,
          'pin': pin,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Deposit failed'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Deposit failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Withdraw from savings
  Future<Result<void>> withdrawFromSavings({
    required String savingsId,
    required int amount,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        '/api/savings/$savingsId/withdraw',
        data: {
          'amount': amount,
          'pin': pin,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Withdrawal failed'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Withdrawal failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Break/close savings early
  Future<Result<void>> breakSavings({
    required String savingsId,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        '/api/savings/$savingsId/break',
        data: {'pin': pin},
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFailure(message: 'Failed to break savings'));
      }
    } on DioException catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'Failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
