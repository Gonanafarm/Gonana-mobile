// Wallet model without Hive

class WalletBalance {
  final int ngnBalance;

  final double? ethBalance;

  final double? ccdBalance;

  final String? accountNumber;

  final String? bankName;

  WalletBalance({
    this.ngnBalance = 0,
    this.ethBalance,
    this.ccdBalance,
    this.accountNumber,
    this.bankName,
  });

  String get ngnFormatted => '₦${ngnBalance.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';

  String get ethFormatted => ethBalance != null
      ? '${ethBalance!.toStringAsFixed(6)} ETH'
      : '0.000000 ETH';

  String get ccdFormatted => ccdBalance != null
      ? '${ccdBalance!.toStringAsFixed(4)} CCD'
      : '0.0000 CCD';

  // Convenience getters for compatibility
  int get balance => ngnBalance;
  String get balanceFormatted => ngnFormatted;

  factory WalletBalance.fromJson(Map<String, dynamic> json) {
    return WalletBalance(
      ngnBalance: json['ngnBalance'] ?? json['balance'] ?? 0,
      ethBalance: json['ethBalance']?.toDouble(),
      ccdBalance: json['ccdBalance']?.toDouble(),
      accountNumber: json['accountNumber'],
      bankName: json['bankName'],
    );
  }
}

class Transaction {
  final String id;

  final String type; // credit, debit, transfer

  final int amount;

  final String currency; // NGN, ETH, CCD

  final String description;

  final String? reference;

  final String status; // pending, completed, failed

  final String? recipientName;

  final String createdAt;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    this.currency = 'NGN',
    required this.description,
    this.reference,
    this.status = 'completed',
    this.recipientName,
    required this.createdAt,
  });

  bool get isCredit => type.toLowerCase() == 'credit';
  bool get isDebit => type.toLowerCase() == 'debit';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isCompleted => status.toLowerCase() == 'completed';
  bool get isFailed => status.toLowerCase() == 'failed';

  String get amountFormatted {
    final sign = isCredit ? '+' : '-';
    final formatted = amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    return '$sign₦$formatted';
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? json['id'] ?? '',
      type: json['type'] ?? 'transfer',
      amount: json['amount'] ?? 0,
      currency: json['currency'] ?? 'NGN',
      description: json['description'] ?? json['narration'] ?? '',
      reference: json['reference'],
      status: json['status'] ?? 'completed',
      recipientName: json['recipientName'] ?? json['recipient_name'],
      createdAt: json['created_at'] ??
          json['createdAt'] ??
          DateTime.now().toIso8601String(),
    );
  }
}
