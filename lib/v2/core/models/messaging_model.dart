import 'package:flutter/material.dart';

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.imageUrl,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['_id'] ?? json['id'] ?? '',
      senderId: json['senderId'] ?? json['sender_id'] ?? '',
      receiverId: json['receiverId'] ?? json['receiver_id'] ?? '',
      message: json['message'] ?? '',
      timestamp:
          DateTime.tryParse(json['timestamp'] ?? json['createdAt'] ?? '') ??
              DateTime.now(),
      isRead: json['isRead'] ?? json['is_read'] ?? false,
      imageUrl: json['imageUrl'] ?? json['image_url'],
    );
  }
}

class ChatConversation {
  final String id;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserImage;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;

  ChatConversation({
    required this.id,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserImage,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['_id'] ?? json['id'] ?? '',
      otherUserId: json['otherUserId'] ?? json['other_user_id'] ?? '',
      otherUserName: json['otherUserName'] ?? json['other_user_name'] ?? 'User',
      otherUserImage: json['otherUserImage'] ?? json['other_user_image'],
      lastMessage: json['lastMessage'] ?? json['last_message'],
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.tryParse(json['lastMessageTime'])
          : null,
      unreadCount: json['unreadCount'] ?? json['unread_count'] ?? 0,
    );
  }
}

class Referral {
  final String id;
  final String userId;
  final String referralCode;
  final int totalReferrals;
  final int totalEarnings;
  final List<ReferredUser> referredUsers;

  Referral({
    required this.id,
    required this.userId,
    required this.referralCode,
    this.totalReferrals = 0,
    this.totalEarnings = 0,
    this.referredUsers = const [],
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? '',
      referralCode: json['referralCode'] ?? json['referral_code'] ?? '',
      totalReferrals: json['totalReferrals'] ?? json['total_referrals'] ?? 0,
      totalEarnings: json['totalEarnings'] ?? json['total_earnings'] ?? 0,
      referredUsers: (json['referredUsers'] ?? json['referred_users'] ?? [])
          .map<ReferredUser>((u) => ReferredUser.fromJson(u))
          .toList(),
    );
  }

  String get earningsFormatted => '₦${totalEarnings.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';
}

class ReferredUser {
  final String name;
  final DateTime joinedAt;
  final int earnings;

  ReferredUser({
    required this.name,
    required this.joinedAt,
    required this.earnings,
  });

  factory ReferredUser.fromJson(Map<String, dynamic> json) {
    return ReferredUser(
      name: json['name'] ?? 'User',
      joinedAt: DateTime.tryParse(json['joinedAt'] ?? '') ?? DateTime.now(),
      earnings: json['earnings'] ?? 0,
    );
  }
}

class CryptoWallet {
  final String userId;
  final double ethBalance;
  final double ccdBalance;
  final double bnbBalance;
  final double usdtBalance; // Total across all networks
  final double usdcBalance; // Total across all networks
  final String? ethAddress;
  final String? ccdAddress;
  final String? bnbAddress;
  final String? usdtErc20Address;
  final String? usdtBep20Address;
  final String? usdtTrc20Address;
  final String? usdcErc20Address;
  final String? usdcBep20Address;
  final String? usdcTrc20Address;

  CryptoWallet({
    required this.userId,
    this.ethBalance = 0.0,
    this.ccdBalance = 0.0,
    this.bnbBalance = 0.0,
    this.usdtBalance = 0.0,
    this.usdcBalance = 0.0,
    this.ethAddress,
    this.ccdAddress,
    this.bnbAddress,
    this.usdtErc20Address,
    this.usdtBep20Address,
    this.usdtTrc20Address,
    this.usdcErc20Address,
    this.usdcBep20Address,
    this.usdcTrc20Address,
  });

  String get ethFormatted => '${ethBalance.toStringAsFixed(6)} ETH';
  String get ccdFormatted => '${ccdBalance.toStringAsFixed(4)} CCD';
  String get bnbFormatted => '${bnbBalance.toStringAsFixed(6)} BNB';
  String get usdtFormatted => '\$${usdtBalance.toStringAsFixed(2)} USDT';
  String get usdcFormatted => '\$${usdcBalance.toStringAsFixed(2)} USDC';

  factory CryptoWallet.fromJson(Map<String, dynamic> json) {
    return CryptoWallet(
      userId: json['userId'] ?? '',
      ethBalance: (json['ethBalance'] ?? 0).toDouble(),
      ccdBalance: (json['ccdBalance'] ?? 0).toDouble(),
      bnbBalance: (json['bnbBalance'] ?? 0).toDouble(),
      usdtBalance: (json['usdtBalance'] ?? 0).toDouble(),
      usdcBalance: (json['usdcBalance'] ?? 0).toDouble(),
      ethAddress: json['ethAddress'],
      ccdAddress: json['ccdAddress'],
      bnbAddress: json['bnbAddress'],
      usdtErc20Address: json['usdtErc20Address'],
      usdtBep20Address: json['usdtBep20Address'],
      usdtTrc20Address: json['usdtTrc20Address'],
      usdcErc20Address: json['usdcErc20Address'],
      usdcBep20Address: json['usdcBep20Address'],
      usdcTrc20Address: json['usdcTrc20Address'],
    );
  }
}

class CryptoNetwork {
  final String name;
  final String code;
  final String chain;
  final Color color;

  CryptoNetwork({
    required this.name,
    required this.code,
    required this.chain,
    required this.color,
  });

  static List<CryptoNetwork> getStablecoinNetworks() {
    return [
      CryptoNetwork(
        name: 'Ethereum (ERC20)',
        code: 'ERC20',
        chain: 'ETH',
        color: Colors.purple,
      ),
      CryptoNetwork(
        name: 'BNB Smart Chain (BEP20)',
        code: 'BEP20',
        chain: 'BSC',
        color: Colors.amber,
      ),
      CryptoNetwork(
        name: 'Tron (TRC20)',
        code: 'TRC20',
        chain: 'TRX',
        color: Colors.red,
      ),
    ];
  }
}

class SwapRate {
  final String fromCurrency;
  final String toCurrency;
  final double rate;
  final DateTime timestamp;

  SwapRate({
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.timestamp,
  });

  factory SwapRate.fromJson(Map<String, dynamic> json) {
    return SwapRate(
      fromCurrency: json['fromCurrency'] ?? json['from'] ?? '',
      toCurrency: json['toCurrency'] ?? json['to'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  String get displayRate =>
      '1 $fromCurrency = ${rate.toStringAsFixed(fromCurrency == 'NGN' ? 2 : 6)} $toCurrency';
}
