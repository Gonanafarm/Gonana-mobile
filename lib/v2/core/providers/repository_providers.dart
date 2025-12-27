import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/wallet/data/repositories/wallet_repository.dart';
import '../../features/wallet/data/repositories/savings_repository.dart';
import '../../features/wallet/data/repositories/staking_repository.dart';
import '../../features/profile/data/repositories/kyc_repository.dart';
import '../../features/crypto/data/repositories/crypto_repository.dart';
import '../../features/messaging/data/repositories/messaging_repository.dart';
import '../../features/marketplace/data/repositories/review_repository.dart';
import '../../features/referral/data/repositories/referral_repository.dart';
import '../../features/orders/data/repositories/order_repository.dart';

// ==================== WALLET ====================

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository();
});

// ==================== SAVINGS ====================

final savingsRepositoryProvider = Provider<SavingsRepository>((ref) {
  return SavingsRepository();
});

// ==================== STAKING ====================

final stakingRepositoryProvider = Provider<StakingRepository>((ref) {
  return StakingRepository();
});

// ==================== KYC ====================

final kycRepositoryProvider = Provider<KYCRepository>((ref) {
  return KYCRepository();
});

// ==================== CRYPTO ====================

final cryptoRepositoryProvider = Provider<CryptoRepository>((ref) {
  return CryptoRepository();
});

// ==================== MESSAGING ====================

final messagingRepositoryProvider = Provider<MessagingRepository>((ref) {
  return MessagingRepository();
});

// ==================== REVIEWS ====================

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

// ==================== REFERRALS ====================

final referralRepositoryProvider = Provider<ReferralRepository>((ref) {
  return ReferralRepository();
});

// ==================== ORDERS ====================

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository();
});
