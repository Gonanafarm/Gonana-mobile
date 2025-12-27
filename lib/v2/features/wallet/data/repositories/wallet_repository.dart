import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/wallet_model.dart';
import '../../../../core/utils/failures.dart';

class WalletRepository {
  final Dio _dio = DioClient.instance.dio;

  // Get Wallet Balance
  Future<Result<WalletBalance>> getBalance() async {
    try {
      final response = await _dio.get('/api/wallet/balance');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Right(WalletBalance.fromJson(data));
      } else {
        return const Left(ServerFailure(message: 'Failed to get balance'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Transfer Funds
  Future<Result<String>> transfer({
    required String recipientId,
    required int amount,
    required String pin,
    String? note,
  }) async {
    try {
      final response = await _dio.post(
        '/api/wallet/transfer',
        data: {
          'recipientId': recipientId,
          'amount': amount,
          'pin': pin,
          if (note != null) 'note': note,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data['data']['transactionId'] ?? 'success');
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Transfer failed'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Transfer failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get Transactions
  Future<Result<List<Transaction>>> getTransactions(
      {int page = 1, int limit = 20}) async {
    try {
      final response = await _dio.get(
        '/api/wallet/transactions',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(data.map((json) => Transaction.fromJson(json)).toList());
      } else {
        return const Left(
            ServerFailure(message: 'Failed to load transactions'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Deposit (generate payment link)
  Future<Result<String>> initiateDeposit({required int amount}) async {
    try {
      final response = await _dio.post(
        '/api/wallet/deposit',
        data: {'amount': amount},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data['data']['paymentUrl'] ?? '');
      } else {
        return const Left(ServerFailure(message: 'Failed to initiate deposit'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Deposit failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Withdraw to bank
  Future<Result<String>> withdrawToBank({
    required String bankAccountId,
    required int amount,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        '/api/wallet/withdraw',
        data: {
          'bankAccountId': bankAccountId,
          'amount': amount,
          'pin': pin,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data['data']['transactionId'] ?? 'success');
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
}
