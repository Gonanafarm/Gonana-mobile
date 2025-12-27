class BankAccount {
  final String id;
  final String userId;
  final String bankName;
  final String bankCode;
  final String accountNumber;
  final String accountName;
  final bool isDefault;
  final bool isVerified;
  final DateTime createdAt;

  BankAccount({
    required this.id,
    required this.userId,
    required this.bankName,
    required this.bankCode,
    required this.accountNumber,
    required this.accountName,
    this.isDefault = false,
    this.isVerified = false,
    required this.createdAt,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? json['user_id'] ?? '',
      bankName: json['bankName'] ?? json['bank_name'] ?? '',
      bankCode: json['bankCode'] ?? json['bank_code'] ?? '',
      accountNumber: json['accountNumber'] ?? json['account_number'] ?? '',
      accountName: json['accountName'] ?? json['account_name'] ?? '',
      isDefault: json['isDefault'] ?? json['is_default'] ?? false,
      isVerified: json['isVerified'] ?? json['is_verified'] ?? false,
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? json['created_at'] ?? '') ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'bankName': bankName,
      'bankCode': bankCode,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'isDefault': isDefault,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get maskedAccountNumber =>
      '${accountNumber.substring(0, 3)}****${accountNumber.substring(accountNumber.length - 3)}';
}

class NigerianBank {
  final String name;
  final String code;
  final String logo;

  NigerianBank({
    required this.name,
    required this.code,
    this.logo = '',
  });

  static List<NigerianBank> getAllBanks() {
    return [
      NigerianBank(name: 'Access Bank', code: '044'),
      NigerianBank(name: 'GTBank', code: '058'),
      NigerianBank(name: 'First Bank', code: '011'),
      NigerianBank(name: 'UBA', code: '033'),
      NigerianBank(name: 'Zenith Bank', code: '057'),
      NigerianBank(name: 'Stanbic IBTC', code: '221'),
      NigerianBank(name: 'Sterling Bank', code: '232'),
      NigerianBank(name: 'Polaris Bank', code: '076'),
      NigerianBank(name: 'Fidelity Bank', code: '070'),
      NigerianBank(name: 'Union Bank', code: '032'),
      NigerianBank(name: 'Ecobank', code: '050'),
      NigerianBank(name: 'FCMB', code: '214'),
      NigerianBank(name: 'Wema Bank', code: '035'),
      NigerianBank(name: 'Keystone Bank', code: '082'),
      NigerianBank(name: 'Providus Bank', code: '101'),
      NigerianBank(name: 'Kuda Bank', code: '090267'),
      NigerianBank(name: 'OPay', code: '999992'),
      NigerianBank(name: 'PalmPay', code: '999991'),
    ];
  }
}

class KYCDocument {
  final String id;
  final String userId;
  final String type; // bvn, id_card, passport, selfie
  final String documentUrl;
  final String status; // pending, verified, rejected
  final String? rejectionReason;
  final DateTime uploadedAt;
  final DateTime? verifiedAt;

  KYCDocument({
    required this.id,
    required this.userId,
    required this.type,
    required this.documentUrl,
    this.status = 'pending',
    this.rejectionReason,
    required this.uploadedAt,
    this.verifiedAt,
  });

  factory KYCDocument.fromJson(Map<String, dynamic> json) {
    return KYCDocument(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? '',
      type: json['type'] ?? '',
      documentUrl: json['documentUrl'] ?? json['document_url'] ?? '',
      status: json['status'] ?? 'pending',
      rejectionReason: json['rejectionReason'] ?? json['rejection_reason'],
      uploadedAt:
          DateTime.tryParse(json['uploadedAt'] ?? json['uploaded_at'] ?? '') ??
              DateTime.now(),
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.tryParse(json['verifiedAt'])
          : null,
    );
  }

  bool get isPending => status == 'pending';
  bool get isVerified => status == 'verified';
  bool get isRejected => status == 'rejected';
}

class KYCStatus {
  final bool bvnVerified;
  final bool idCardVerified;
  final bool selfieVerified;
  final int tier; // 1, 2, 3
  final int dailyLimit;
  final int monthlyLimit;
  final bool walletActivated;
  final String? accountNumber;
  final String? ethAddress;
  final String? ccdAddress;

  KYCStatus({
    this.bvnVerified = false,
    this.idCardVerified = false,
    this.selfieVerified = false,
    this.tier = 1,
    this.dailyLimit = 50000,
    this.monthlyLimit = 300000,
    this.walletActivated = false,
    this.accountNumber,
    this.ethAddress,
    this.ccdAddress,
  });

  bool get isFullyVerified => bvnVerified && idCardVerified && selfieVerified;

  int get completionPercentage {
    int verified = 0;
    if (bvnVerified) verified++;
    if (idCardVerified) verified++;
    if (selfieVerified) verified++;
    return (verified / 3 * 100).toInt();
  }

  String get tierName {
    switch (tier) {
      case 3:
        return 'Premium';
      case 2:
        return 'Standard';
      default:
        return 'Basic';
    }
  }

  String get tierDescription {
    switch (tier) {
      case 3:
        return 'Full access to all features';
      case 2:
        return 'Access to crypto & advanced features';
      case 1:
        return 'Limited marketplace access';
      default:
        return 'Basic tier';
    }
  }

  Map<String, bool> get tierFeatures {
    return {
      'marketplace': tier >= 1,
      'wallet': tier >= 2 && walletActivated,
      'crypto': tier >= 2 && walletActivated,
      'savings': tier >= 2 && walletActivated,
      'staking': tier >= 3 && walletActivated,
      'p2pTransfer': tier >= 2 && walletActivated,
      'bankTransfer': tier >= 2 && walletActivated,
    };
  }

  factory KYCStatus.fromJson(Map<String, dynamic> json) {
    return KYCStatus(
      bvnVerified: json['bvnVerified'] ?? json['bvn_verified'] ?? false,
      idCardVerified:
          json['idCardVerified'] ?? json['id_card_verified'] ?? false,
      selfieVerified:
          json['selfieVerified'] ?? json['selfie_verified'] ?? false,
      tier: json['tier'] ?? 1,
      dailyLimit: json['dailyLimit'] ?? json['daily_limit'] ?? 50000,
      monthlyLimit: json['monthlyLimit'] ?? json['monthly_limit'] ?? 300000,
      walletActivated:
          json['walletActivated'] ?? json['wallet_activated'] ?? false,
      accountNumber: json['accountNumber'] ?? json['account_number'],
      ethAddress: json['ethAddress'] ?? json['eth_address'],
      ccdAddress: json['ccdAddress'] ?? json['ccd_address'],
    );
  }
}
