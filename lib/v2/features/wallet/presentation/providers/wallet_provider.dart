import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/wallet_repository.dart';
import '../../../../core/models/wallet_model.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository();
});

final walletProvider =
    StateNotifierProvider<WalletNotifier, WalletState>((ref) {
  return WalletNotifier(ref.read(walletRepositoryProvider));
});

class WalletState {
  final WalletBalance? balance;
  final List<Transaction> transactions;
  final bool isLoading;
  final String? error;

  WalletState({
    this.balance,
    this.transactions = const [],
    this.isLoading = false,
    this.error,
  });

  WalletState copyWith({
    WalletBalance? balance,
    List<Transaction>? transactions,
    bool? isLoading,
    String? error,
  }) {
    return WalletState(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class WalletNotifier extends StateNotifier<WalletState> {
  final WalletRepository _repository;

  WalletNotifier(this._repository) : super(WalletState()) {
    loadWallet();
  }

  Future<void> loadWallet() async {
    state = state.copyWith(isLoading: true, error: null);

    final balanceResult = await _repository.getWalletBalance();
    final transactionsResult = await _repository.getTransactions();

    balanceResult.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (balance) {
        transactionsResult.fold(
          (failure) {
            state = state.copyWith(
              balance: balance,
              isLoading: false,
              error: failure.message,
            );
          },
          (transactions) {
            state = state.copyWith(
              balance: balance,
              transactions: transactions,
              isLoading: false,
              error: null,
            );
          },
        );
      },
    );
  }

  Future<bool> transferToUser({
    required String recipientEmail,
    required int amount,
    String? description,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.transferToUser(
      recipientEmail: recipientEmail,
      amount: amount,
      description: description,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
        return false;
      },
      (success) {
        // Reload wallet after successful transfer
        loadWallet();
        return true;
      },
    );
  }

  Future<void> refresh() => loadWallet();
}
