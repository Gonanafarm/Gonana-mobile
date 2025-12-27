class SavingsAccount {
  final String id;
  final String userId;
  final String name;
  final int balance;
  final int targetAmount;
  final double interestRate; // Annual percentage
  final DateTime startDate;
  final DateTime? maturityDate;
  final String type; // fixed, flexible
  final String status; // active, matured, closed

  // Convenience getters for compatibility
  int get currentBalance => balance;
  DateTime get endDate =>
      maturityDate ?? DateTime.now().add(const Duration(days: 90));

  SavingsAccount({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.targetAmount,
    required this.interestRate,
    required this.startDate,
    this.maturityDate,
    this.type = 'flexible',
    this.status = 'active',
  });

  factory SavingsAccount.fromJson(Map<String, dynamic> json) {
    return SavingsAccount(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? json['user_id'] ?? '',
      name: json['name'] ?? 'Savings',
      balance: json['balance'] ?? 0,
      targetAmount: json['targetAmount'] ?? json['target_amount'] ?? 0,
      interestRate:
          (json['interestRate'] ?? json['interest_rate'] ?? 0).toDouble(),
      startDate:
          DateTime.tryParse(json['startDate'] ?? json['start_date'] ?? '') ??
              DateTime.now(),
      maturityDate:
          json['maturityDate'] != null || json['maturity_date'] != null
              ? DateTime.tryParse(
                  json['maturityDate'] ?? json['maturity_date'] ?? '')
              : null,
      type: json['type'] ?? 'flexible',
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'balance': balance,
      'targetAmount': targetAmount,
      'interestRate': interestRate,
      'startDate': startDate.toIso8601String(),
      if (maturityDate != null) 'maturityDate': maturityDate!.toIso8601String(),
      'type': type,
      'status': status,
    };
  }

  String get balanceFormatted =>
      '₦${balance.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          )}';

  String get targetFormatted =>
      '₦${targetAmount.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          )}';

  String get targetAmountFormatted => targetFormatted;
  String get estimatedInterestFormatted =>
      '₦${estimatedInterest.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          )}';
  String get progressFormatted => '${progress.toStringAsFixed(1)}%';
  String get interestRateFormatted => '${interestRate.toStringAsFixed(1)}%';

  double get progress =>
      targetAmount > 0 ? (balance / targetAmount * 100).clamp(0, 100) : 0;

  int get durationDays => maturityDate != null
      ? maturityDate!.difference(startDate).inDays
      : DateTime.now().difference(startDate).inDays;

  int get estimatedInterest =>
      ((balance * interestRate * durationDays) / (365 * 100)).toInt();

  int get daysRemaining => maturityDate != null
      ? maturityDate!.difference(DateTime.now()).inDays.clamp(0, 9999)
      : 90;

  bool get isMatured =>
      maturityDate != null && DateTime.now().isAfter(maturityDate!);
  bool get isActive => status == 'active';

  // Mock data generator for testing
  static List<SavingsAccount> getMockAccounts() {
    return [
      SavingsAccount(
        id: '1',
        userId: 'user123',
        name: 'Emergency Fund',
        balance: 350000,
        targetAmount: 500000,
        interestRate: 12.0,
        startDate: DateTime.now().subtract(const Duration(days: 60)),
        maturityDate: DateTime.now().add(const Duration(days: 30)),
      ),
      SavingsAccount(
        id: '2',
        userId: 'user123',
        name: 'Vacation Savings',
        balance: 150000,
        targetAmount: 300000,
        interestRate: 10.0,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        maturityDate: DateTime.now().add(const Duration(days: 60)),
      ),
      SavingsAccount(
        id: '3',
        userId: 'user123',
        name: 'New Phone',
        balance: 180000,
        targetAmount: 200000,
        interestRate: 8.0,
        startDate: DateTime.now().subtract(const Duration(days: 90)),
        maturityDate: DateTime.now().add(const Duration(days: 10)),
      ),
    ];
  }
}

class StakingPosition {
  final String id;
  final String userId;
  final int amount;
  final double apy; // Annual percentage yield
  final DateTime startDate;
  final DateTime endDate;
  final int totalRewards;
  final int claimedRewards;
  final String status; // active, completed, unstaked

  StakingPosition({
    required this.id,
    required this.userId,
    required this.amount,
    required this.apy,
    required this.startDate,
    required this.endDate,
    this.totalRewards = 0,
    this.claimedRewards = 0,
    this.status = 'active',
  });

  factory StakingPosition.fromJson(Map<String, dynamic> json) {
    return StakingPosition(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? json['user_id'] ?? '',
      amount: json['amount'] ?? 0,
      apy: (json['apy'] ?? 0).toDouble(),
      startDate:
          DateTime.tryParse(json['startDate'] ?? json['start_date'] ?? '') ??
              DateTime.now(),
      endDate: DateTime.tryParse(json['endDate'] ?? json['end_date'] ?? '') ??
          DateTime.now(),
      totalRewards: json['totalRewards'] ?? json['total_rewards'] ?? 0,
      claimedRewards: json['claimedRewards'] ?? json['claimed_rewards'] ?? 0,
      status: json['status'] ?? 'active',
    );
  }

  String get amountFormatted => '₦${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';

  String get rewardsFormatted =>
      '₦${totalRewards.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          )}';

  int get pendingRewards => totalRewards - claimedRewards;

  int get daysRemaining =>
      endDate.difference(DateTime.now()).inDays.clamp(0, 9999);

  bool get isCompleted => DateTime.now().isAfter(endDate);
  bool get isActive => status == 'active';
  bool get canClaim => pendingRewards > 0;
}
