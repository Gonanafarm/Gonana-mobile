import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/bank_model.dart';
import '../../../../core/utils/failures.dart';

class BankRepository {
  final Dio _dio = DioClient.instance.dio;

  // Get all Nigerian banks
  Future<Result<List<NigerianBank>>> getBanks() async {
    try {
      // Return static list for now
      await Future.delayed(const Duration(milliseconds: 300));
      return Right(NigerianBank.getAllBanks());
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Add bank account
  Future<Result<BankAccount>> addBankAccount({
    required String bankCode,
    required String accountNumber,
  }) async {
    try {
      final response = await _dio.post(
        '/api/user/bank-accounts',
        data: {
          'bankCode': bankCode,
          'accountNumber': accountNumber,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(BankAccount.fromJson(response.data['data']));
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Failed to add account'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Failed to add account'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get user's bank accounts
  Future<Result<List<BankAccount>>> getUserBankAccounts() async {
    try {
      final response = await _dio.get('/api/user/bank-accounts');

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(data.map((json) => BankAccount.fromJson(json)).toList());
      } else {
        return const Left(ServerFailure(message: 'Failed to load accounts'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Verify account
  Future<Result<String>> verifyAccount({
    required String bankCode,
    required String accountNumber,
  }) async {
    try {
      final response = await _dio.post(
        '/api/user/bank-accounts/verify',
        data: {
          'bankCode': bankCode,
          'accountNumber': accountNumber,
        },
      );

      if (response.statusCode == 200) {
        return Right(response.data['data']['accountName'] ?? 'Account Holder');
      } else {
        return const Left(ServerFailure(message: 'Verification failed'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Verification failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Delete bank account
  Future<Result<void>> deleteBankAccount(String accountId) async {
    try {
      final response = await _dio.delete('/api/user/bank-accounts/$accountId');

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFailure(message: 'Failed to delete account'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Failed to delete'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Set default account
  Future<Result<void>> setDefaultAccount(String accountId) async {
    try {
      final response = await _dio.put(
        '/api/user/bank-accounts/$accountId/default',
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFailure(message: 'Failed to set default'));
      }
    } on DioException catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'Failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
