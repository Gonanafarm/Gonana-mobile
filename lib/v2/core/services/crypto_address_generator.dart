import 'dart:math';

class CryptoAddressGenerator {
  static final CryptoAddressGenerator instance =
      CryptoAddressGenerator._internal();
  factory CryptoAddressGenerator() => instance;
  CryptoAddressGenerator._internal();

  final Random _random = Random();

  // Generate Ethereum address (0x + 40 hex characters)
  String generateEthAddress() {
    const chars = '0123456789abcdef';
    final address = List.generate(
      40,
      (index) => chars[_random.nextInt(chars.length)],
    ).join();
    return '0x$address';
  }

  // Generate Concordium address (alphanumeric, 48 characters)
  String generateCcdAddress() {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    return List.generate(
      48,
      (index) => chars[_random.nextInt(chars.length)],
    ).join();
  }

  // Generate BNB address (similar to ETH)
  String generateBnbAddress() {
    const chars = '0123456789abcdef';
    final address = List.generate(
      40,
      (index) => chars[_random.nextInt(chars.length)],
    ).join();
    return '0x$address';
  }

  // Generate Tron address (starts with T, 34 characters)
  String generateTronAddress() {
    const chars = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
    final address = List.generate(
      33,
      (index) => chars[_random.nextInt(chars.length)],
    ).join();
    return 'T$address';
  }

  // Generate all crypto addresses at once (after KYC)
  Map<String, String> generateAllCryptoAddresses() {
    final ethAddress = generateEthAddress();
    final bnbAddress = generateBnbAddress();
    final tronAddress = generateTronAddress();

    return {
      'eth': ethAddress,
      'ccd': generateCcdAddress(),
      'bnb': bnbAddress,
      // Stablecoins use same addresses as their base chains
      'usdt_erc20': ethAddress, // USDT on Ethereum
      'usdt_bep20': bnbAddress, // USDT on BSC
      'usdt_trc20': tronAddress, // USDT on Tron
      'usdc_erc20': ethAddress, // USDC on Ethereum
      'usdc_bep20': bnbAddress, // USDC on BSC
      'usdc_trc20': tronAddress, // USDC on Tron
    };
  }
}
