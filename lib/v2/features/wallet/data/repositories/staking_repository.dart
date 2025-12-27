import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/staking_model.dart';
import '../../../../core/utils/failures.dart';

class StakingRepository {
  final Dio _dio = DioClient.instance.dio;

  // Create staking position
  Future<Result<StakingPosition>> createStake({
    required int amount,
    required int lockPeriodDays,
    required double apy,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        '/api/staking/create',
        data: {
          'amount': amount,
          'lockPeriodDays': lockPeriodDays,
          'apy': apy,
          'pin': pin,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(StakingPosition.fromJson(response.data['data']));
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Failed to create stake'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Staking failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get all staking positions
  Future<Result<List<StakingPosition>>> getStakingPositions() async {
    try {
      final response = await _dio.get('/api/staking');

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(
            data.map((json) => StakingPosition.fromJson(json)).toList());
      } else {
        return const Left(ServerFailure(message: 'Failed to load staking'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Claim rewards
  Future<Result<int>> claimRewards({
    required String stakingId,
  }) async {
    try {
      final response = await _dio.post('/api/staking/$stakingId/claim');

      if (response.statusCode == 200) {
        return Right(response.data['data']['rewardsClaimed'] ?? 0);
      } else {
        return const Left(ServerFailure(message: 'Failed to claim rewards'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Claim failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Unstake (withdraw principal + rewards)
  Future<Result<void>> unstake({
    required String stakingId,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        '/api/staking/$stakingId/unstake',
        data: {'pin': pin},
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'Unstake failed'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Unstake failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get staking packages/plans
  Future<Result<List<Map<String, dynamic>>>> getStakingPlans() async {
    try {
      final response = await _dio.get('/api/staking/plans');

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return Right(data.cast<Map<String, dynamic>>());
      } else {
        return const Left(ServerFailure(message: 'Failed to load plans'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
