import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/messaging_model.dart';

// Enhanced Crypto Screen with Charts, Analytics, and Multi-Network Support
class EnhancedCryptoWalletScreen extends ConsumerStatefulWidget {
  const EnhancedCryptoWalletScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EnhancedCryptoWalletScreen> createState() =>
      _EnhancedCryptoWalletScreenState();
}

class _EnhancedCryptoWalletScreenState
    extends ConsumerState<EnhancedCryptoWalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCrypto = 'ETH';
  String _selectedNetwork = 'ERC20';
  String _chartPeriod = '1D'; // 1D, 1W, 1M, 1Y

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Crypto Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showPriceAlerts(),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _showTransactionHistory(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Portfolio'),
            Tab(text: 'Markets'),
            Tab(text: 'News'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPortfolioTab(),
          _buildMarketsTab(),
          _buildNewsTab(),
        ],
      ),
    );
  }

  Widget _buildPortfolioTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Portfolio Value Card
          _buildPortfolioValueCard(),
          const SizedBox(height: 24),

          // Quick Actions
          _buildQuickActions(),
          const SizedBox(height: 24),

          // Assets List
          const Text(
            'Your Assets',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildCryptoAssetCard('ETH', 'Ethereum', 0.45, 2850.00, 5.2),
          _buildCryptoAssetCard('BNB', 'Binance Coin', 2.3, 320.00, -2.8),
          _buildCryptoAssetCard('CCD', 'Concordium', 1500.0, 0.05, 12.5),
          _buildStablecoinCard('USDT', 'Tether', 5000.00),
          _buildStablecoinCard('USDC', 'USD Coin', 3000.00),
        ],
      ),
    );
  }

  Widget _buildPortfolioValueCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF667eea),
            const Color(0xFF764ba2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Portfolio Value',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$9,582.50',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.trending_up, color: AppTheme.successColor, size: 18),
              const SizedBox(width: 4),
              Text(
                '+₦285,000 (3.14%)',
                style: TextStyle(
                  color: AppTheme.successColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Today',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Mini Chart
          SizedBox(
            height: 80,
            child: _buildMiniChart(),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2);
  }

  Widget _buildMiniChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 1.5),
              FlSpot(2, 1.4),
              FlSpot(3, 2),
              FlSpot(4, 1.8),
              FlSpot(5, 2.5),
              FlSpot(6, 3),
            ],
            isCurved: true,
            color: Colors.white,
            barWidth: 2,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
            child: _buildActionButton(
                'Buy', Icons.add_circle, AppTheme.successColor)),
        const SizedBox(width: 12),
        Expanded(
            child: _buildActionButton(
                'Sell', Icons.remove_circle, AppTheme.errorColor)),
        const SizedBox(width: 12),
        Expanded(
            child: _buildActionButton(
                'Swap', Icons.swap_horiz, AppTheme.primaryColor)),
        const SizedBox(width: 12),
        Expanded(child: _buildActionButton('Send', Icons.send, Colors.purple)),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate().scale(delay: 100.ms);
  }

  Widget _buildCryptoAssetCard(
      String symbol, String name, double amount, double price, double change) {
    final isPositive = change >= 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Crypto Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getCryptoColor(symbol).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                symbol,
                style: TextStyle(
                  color: _getCryptoColor(symbol),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$amount $symbol',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Value & Change
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${(amount * price).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppTheme.successColor.withOpacity(0.1)
                      : AppTheme.errorColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: isPositive
                          ? AppTheme.successColor
                          : AppTheme.errorColor,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${change.abs()}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isPositive
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.2);
  }

  Widget _buildStablecoinCard(String symbol, String name, double amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                symbol,
                style: const TextStyle(
                  color: AppTheme.successColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => _showNetworkSelector(symbol),
                  child: Row(
                    children: [
                      Text(
                        _selectedNetwork,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 18,
                        color: AppTheme.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketsTab() {
    return Center(child: Text('Markets Coming Soon'));
  }

  Widget _buildNewsTab() {
    return Center(child: Text('Crypto News Coming Soon'));
  }

  Color _getCryptoColor(String symbol) {
    switch (symbol) {
      case 'ETH':
        return const Color(0xFF627EEA);
      case 'BNB':
        return const Color(0xFFF3BA2F);
      case 'CCD':
        return const Color(0xFF00B4D8);
      default:
        return AppTheme.primaryColor;
    }
  }

  void _showPriceAlerts() {
    // TODO: Show price alerts dialog
  }

  void _showTransactionHistory() {
    // TODO: Show transaction history
  }

  void _showNetworkSelector(String symbol) {
    // TODO: Show network selector bottom sheet
  }
}
