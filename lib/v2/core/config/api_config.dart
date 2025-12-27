/// API Configuration for Gonana V2
class ApiConfig {
  // Base URLs
  static const String productionUrl = 'https://api.gonana.com';
  static const String devUrl = 'https://dev-api.gonana.com';
  static const String localUrl = 'http://localhost:3000';
  
  // Environment
  static const Environment currentEnv = Environment.dev;
  
  // API Version
  static const String apiVersion = 'v1';
  
  // Computed Base URL
  static String get baseUrl {
    switch (currentEnv) {
      case Environment.production:
        return productionUrl;
      case Environment.dev:
        return devUrl;
      case Environment.local:
        return localUrl;
    }
  }
  
  static String get apiBaseUrl => '$baseUrl/api/$apiVersion';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Retry Configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  
  // Endpoints
  static class Endpoints {
    // Auth
    static const String login = '/auth/login';
    static const String signup = '/auth/signup';
    static const String refreshToken = '/auth/refresh';
    
    // Wallet
    static const String walletBalance = '/wallet/balance';
    static const String walletTransfer = '/wallet/transfer';
    static const String transactions = '/wallet/transactions';
    static const String deposit = '/wallet/deposit';
    static const String withdraw = '/wallet/withdraw';
    
    // Savings
    static const String savingsAccounts = '/savings/accounts';
    static const String createSavings = '/savings/create';
    static const String depositSavings = '/savings/deposit';
    static const String withdrawSavings = '/savings/withdraw';
    
    // Staking
    static const String stakingPositions = '/staking/positions';
    static const String stakingPools = '/staking/pools';
    static const String stake = '/staking/stake';
    static const String unstake = '/staking/unstake';
    static const String claimRewards = '/staking/claim';
    
    // Crypto
    static const String cryptoPortfolio = '/crypto/portfolio';
    static const String cryptoRates = '/crypto/rates';
    static const String cryptoBuy = '/crypto/buy';
    static const String cryptoSell = '/crypto/sell';
    static const String cryptoSwap = '/crypto/swap';
    
    // Orders
    static const String orders = '/orders';
    static const String orderDetails = '/orders/:id';
    static const String reorder = '/orders/reorder';
    
    // KYC
    static const String kycStatus = '/kyc/status';
    static const String kycSubmit = '/kyc/submit';
    static const String kycVerify = '/kyc/verify';
  }
}

enum Environment {
  production,
  dev,
  local,
}
