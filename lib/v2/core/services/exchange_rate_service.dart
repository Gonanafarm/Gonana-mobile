import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeRateService {
  static final ExchangeRateService instance = ExchangeRateService._internal();
  factory ExchangeRateService() => instance;
  ExchangeRateService._internal();

  double _usdToNgnRate = 1550.0; // Default rate
  DateTime? _lastUpdate;

  double get usdToNgnRate => _usdToNgnRate;

  // Fetch real-time exchange rate
  Future<void> fetchExchangeRate() async {
    // Check if we need to update (cache for 1 hour)
    if (_lastUpdate != null &&
        DateTime.now().difference(_lastUpdate!).inHours < 1) {
      return;
    }

    try {
      // Using a free exchange rate API
      final response = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _usdToNgnRate = (data['rates']['NGN'] ?? 1550.0).toDouble();
        _lastUpdate = DateTime.now();
      }
    } catch (e) {
      // Use default rate on error
      _usdToNgnRate = 1550.0;
    }
  }

  // Convert NGN to USD
  double ngnToUsd(int ngn) {
    return ngn / _usdToNgnRate;
  }

  // Convert USD to NGN
  int usdToNgn(double usd) {
    return (usd * _usdToNgnRate).toInt();
  }

  // Format NGN with USD equivalent
  String formatWithUsd(int ngn) {
    final usd = ngnToUsd(ngn);
    return '₦${ngn.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )} (~\$${usd.toStringAsFixed(2)})';
  }

  // Get current rate display
  String get rateDisplay => '1 USD = ₦${_usdToNgnRate.toStringAsFixed(2)}';
}
