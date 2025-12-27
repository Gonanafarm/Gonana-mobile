import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/bank_model.dart';
import '../../../../core/services/crypto_address_generator.dart';
import '../../../../core/utils/failures.dart';

class KYCRepository {
  final Dio _dio = DioClient.instance.dio;

  // Submit BVN
  Future<Result<void>> submitBVN(String bvn) async {
    try {
      final response = await _dio.post(
        '/api/kyc/bvn',
        data: {'bvn': bvn},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? 'BVN verification failed'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'BVN verification failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Upload document
  Future<Result<void>> uploadDocument({
    required String type,
    required String filePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'type': type,
        'document': await MultipartFile.fromFile(filePath),
      });

      final response = await _dio.post(
        '/api/kyc/upload-document',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return const Left(ServerFailure(message: 'Document upload failed'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Upload failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Get KYC status
  Future<Result<KYCStatus>> getKYCStatus() async {
    try {
      final response = await _dio.get('/api/kyc/status');

      if (response.statusCode == 200) {
        return Right(KYCStatus.fromJson(response.data['data']));
      } else {
        return const Left(ServerFailure(message: 'Failed to load KYC status'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Activate wallet (after KYC complete)
  Future<Result<Map<String, String>>> activateWallet() async {
    try {
      // Generate addresses locally first
      final addresses =
          CryptoAddressGenerator.instance.generateAllCryptoAddresses();

      final response = await _dio.post(
        '/api/kyc/activate-wallet',
        data: {
          'ethAddress': addresses['eth'],
          'ccdAddress': addresses['ccd'],
          'bnbAddress': addresses['bnb'],
          'usdtErc20': addresses['usdt_erc20'],
          'usdtBep20': addresses['usdt_bep20'],
          'usdtTrc20': addresses['usdt_trc20'],
          'usdcErc20': addresses['usdc_erc20'],
          'usdcBep20': addresses['usdc_bep20'],
          'usdcTrc20': addresses['usdc_trc20'],
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        return Right({
          'accountNumber': data['accountNumber'] ?? '',
          ...addresses,
        });
      } else {
        return const Left(ServerFailure(message: 'Wallet activation failed'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Activation failed'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
