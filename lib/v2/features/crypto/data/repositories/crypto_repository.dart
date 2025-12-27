import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/messaging_model.dart';
import '../../../../core/utils/failures.dart';

class CryptoRepository {
  final Dio _dio = DioClient.instance.dio;

  // Get crypto wallet balances
  Future<Result<CryptoWallet>> getCryptoWallet() async {
    try {
      final response = await _dio.get('/api/crypto/wallet');

      if (response.statusCode == 200) {
        return Right(CryptoWallet.fromJson(response.data['data']));
      } else {
        return const Left(ServerFailure(message: 'Failed to load wallet'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Deposit crypto (returns deposit address)
  Future<Result<String>> getDepositAddress({
    required String currency,
    required String? network,
  }) async {
    try {
      final response = await _dio.post(
        '/api/crypto/deposit',
        data: {
          'currency': currency,
          if (network != null) 'network': network,
        },
      );

      if (response.statusCode == 200) {
        return Right(response.data['data']['address'] ?? '');
      } else {
        return const Left(ServerFailure(message: 'Failed to get address'));
      }
    } on DioException catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'Failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Withdraw crypto
  Future<Result<String>> withdrawCrypto({
    required String currency,
    required String network,
    required String toAddress,
    required double amount,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        '/api/crypto/withdraw',
        data: {
          'currency': currency,
          'network': network,
          'toAddress': toAddress,
          'amount': amount,
          'pin': pin,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data['data']['txHash'] ?? 'success');
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

  // Swap currencies
  Future<Result<void>> swapCurrency({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        '/api/crypto/swap',
        data: {
          'fromCurrency': fromCurrency,
          'toCurrency': toCurrency,
          'amount': amount,
          'pin': pin,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(
            ServerFailure(message: response.data['message'] ?? 'Swap failed'));
      }
    } on DioException catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'Swap failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get crypto transactions
  Future<Result<List<Map<String, dynamic>>>> getCryptoTransactions({
    String? currency,
  }) async {
    try {
      final response = await _dio.get(
        '/api/crypto/transactions',
        queryParameters: {
          if (currency != null) 'currency': currency,
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(data.cast<Map<String, dynamic>>());
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

  // Get exchange rates
  Future<Result<Map<String, double>>> getExchangeRates() async {
    try {
      final response = await _dio.get('/api/crypto/rates');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'] ?? {};
        return Right(
            data.map((key, value) => MapEntry(key, (value as num).toDouble())));
      } else {
        return const Left(ServerFailure(message: 'Failed to load rates'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
