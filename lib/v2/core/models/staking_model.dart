class StakingPosition {
  final String id;
  final String userId;
  final int amount;
  final int lockPeriodDays;
  final double apy;
  final DateTime startDate;
  final DateTime endDate;
  final int rewardsEarned;
  final int rewardsClaimed;
  final String status; // active, completed, withdrawn
  final DateTime createdAt;

  StakingPosition({
    required this.id,
    required this.userId,
    required this.amount,
    required this.lockPeriodDays,
    required this.apy,
    required this.startDate,
    required this.endDate,
    this.rewardsEarned = 0,
    this.rewardsClaimed = 0,
    this.status = 'active',
    required this.createdAt,
  });

  // Calculate current rewards
  int get currentRewards {
    if (status != 'active') return rewardsEarned;

    final now = DateTime.now();
    final daysStaked = now.difference(startDate).inDays;
    final dailyRate = apy / 365 / 100;
    return (amount * dailyRate * daysStaked).toInt();
  }

  // Total value (principal + rewards)
  int get totalValue => amount + currentRewards;

  // Unclaimed rewards
  int get unclaimedRewards => currentRewards - rewardsClaimed;

  // Days remaining
  int get daysRemaining {
    final now = DateTime.now();
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inDays;
  }

  // Is locked (can't withdraw early)
  bool get isLocked {
    final now = DateTime.now();
    return now.isBefore(endDate) && status == 'active';
  }

  // Progress percentage
  double get progressPercentage {
    final totalDays = endDate.difference(startDate).inDays;
    final elapsedDays = DateTime.now().difference(startDate).inDays;
    return (elapsedDays / totalDays * 100).clamp(0, 100);
  }

  // Formatted values
  String get amountFormatted => '₦${amount.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';

  String get rewardsFormatted => '₦${currentRewards.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';

  String get totalValueFormatted => '₦${totalValue.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';

  String get apyFormatted => '${apy.toStringAsFixed(2)}%';

  factory StakingPosition.fromJson(Map<String, dynamic> json) {
    return StakingPosition(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? json['user_id'] ?? '',
      amount: json['amount'] ?? 0,
      lockPeriodDays: json['lockPeriodDays'] ?? json['lock_period_days'] ?? 30,
      apy: (json['apy'] ?? 0).toDouble(),
      startDate:
          DateTime.tryParse(json['startDate'] ?? json['start_date'] ?? '') ??
              DateTime.now(),
      endDate: DateTime.tryParse(json['endDate'] ?? json['end_date'] ?? '') ??
          DateTime.now().add(const Duration(days: 30)),
      rewardsEarned: json['rewardsEarned'] ?? json['rewards_earned'] ?? 0,
      rewardsClaimed: json['rewardsClaimed'] ?? json['rewards_claimed'] ?? 0,
      status: json['status'] ?? 'active',
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? json['created_at'] ?? '') ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'lockPeriodDays': lockPeriodDays,
      'apy': apy,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'rewardsEarned': rewardsEarned,
      'rewardsClaimed': rewardsClaimed,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  StakingPosition copyWith({
    String? id,
    String? userId,
    int? amount,
    int? lockPeriodDays,
    double? apy,
    DateTime? startDate,
    DateTime? endDate,
    int? rewardsEarned,
    int? rewardsClaimed,
    String? status,
    DateTime? createdAt,
  }) {
    return StakingPosition(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      lockPeriodDays: lockPeriodDays ?? this.lockPeriodDays,
      apy: apy ?? this.apy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rewardsEarned: rewardsEarned ?? this.rewardsEarned,
      rewardsClaimed: rewardsClaimed ?? this.rewardsClaimed,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Mock data for testing
  static List<StakingPosition> getMockPositions() {
    return [
      StakingPosition(
        id: '1',
        userId: 'user1',
        amount: 50000,
        lockPeriodDays: 30,
        apy: 12.0,
        startDate: DateTime.now().subtract(const Duration(days: 15)),
        endDate: DateTime.now().add(const Duration(days: 15)),
        rewardsEarned: 250,
        rewardsClaimed: 0,
        status: 'active',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      StakingPosition(
        id: '2',
        userId: 'user1',
        amount: 100000,
        lockPeriodDays: 90,
        apy: 18.0,
        startDate: DateTime.now().subtract(const Duration(days: 45)),
        endDate: DateTime.now().add(const Duration(days: 45)),
        rewardsEarned: 2250,
        rewardsClaimed: 1000,
        status: 'active',
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
      ),
    ];
  }
}
