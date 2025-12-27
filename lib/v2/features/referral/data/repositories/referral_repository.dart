import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/messaging_model.dart';
import '../../../../core/utils/failures.dart';

class ReferralRepository {
  final Dio _dio = DioClient.instance.dio;

  // Get user's referral data
  Future<Result<Referral>> getReferralData() async {
    try {
      final response = await _dio.get('/api/referrals/code');

      if (response.statusCode == 200) {
        return Right(Referral.fromJson(response.data['data']));
      } else {
        return const Left(
            ServerFailure(message: 'Failed to load referral data'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Apply referral code
  Future<Result<void>> applyReferralCode(String code) async {
    try {
      final response = await _dio.post(
        '/api/referrals/apply-code',
        data: {'code': code},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Invalid referral code'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Invalid code'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get referral earnings
  Future<Result<Map<String, dynamic>>> getReferralEarnings() async {
    try {
      final response = await _dio.get('/api/referrals/earnings');

      if (response.statusCode == 200) {
        return Right(response.data['data'] ?? {});
      } else {
        return const Left(ServerFailure(message: 'Failed to load earnings'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Withdraw referral earnings
  Future<Result<void>> withdrawEarnings({
    required int amount,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        '/api/referrals/withdraw',
        data: {
          'amount': amount,
          'pin': pin,
        },
      );

      if (response.statusCode == 200) {
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
}
