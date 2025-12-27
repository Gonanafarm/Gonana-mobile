import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/models/messaging_model.dart';

class CryptoWalletScreen extends ConsumerWidget {
  const CryptoWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = _getMockWallet();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CurrencySwapScreen()),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Main Cryptocurrencies
          Text(
            'Cryptocurrencies',
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.sm),

          _buildCryptoCard(
              context,
              'Ethereum',
              'ETH',
              wallet.ethFormatted,
              wallet.ethAddress ?? 'Not connected',
              Colors.purple,
              Icons.currency_bitcoin),
          const SizedBox(height: AppSpacing.sm),

          _buildCryptoCard(
              context,
              'BNB',
              'BNB',
              wallet.bnbFormatted,
              wallet.bnbAddress ?? 'Not connected',
              Colors.amber,
              Icons.currency_bitcoin),
          const SizedBox(height: AppSpacing.sm),

          _buildCryptoCard(
              context,
              'Concordium',
              'CCD',
              wallet.ccdFormatted,
              wallet.ccdAddress ?? 'Not connected',
              Colors.green,
              Icons.currency_bitcoin),

          const SizedBox(height: AppSpacing.xl),

          // Stablecoins
          Text(
            'Stablecoins',
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.sm),

          _buildStablecoinCard(
            context,
            'Tether',
            'USDT',
            wallet.usdtFormatted,
            wallet,
            'usdt',
            Colors.green.shade600,
          ),
          const SizedBox(height: AppSpacing.sm),

          _buildStablecoinCard(
            context,
            'USD Coin',
            'USDC',
            wallet.usdcFormatted,
            wallet,
            'usdc',
            Colors.blue.shade600,
          ),

          const SizedBox(height: AppSpacing.xl),

          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showDepositDialog(context, 'ETH'),
                  icon: const Icon(Icons.add),
                  label: const Text('Deposit'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showWithdrawDialog(context, 'ETH'),
                  icon: const Icon(Icons.remove),
                  label: const Text('Withdraw'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoCard(
    BuildContext context,
    String name,
    String symbol,
    String balance,
    String address,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(symbol,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              balance,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (address != 'Not connected')
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: address));
                      context.showSuccessSnackBar('Address copied!');
                    },
                    icon: const Icon(Icons.copy, size: 16),
                  ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.2, end: 0);
  }

  Widget _buildStablecoinCard(
    BuildContext context,
    String name,
    String symbol,
    String balance,
    CryptoWallet wallet,
    String type,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(Icons.attach_money, color: color),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(symbol,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      _showNetworkSelector(context, symbol, wallet, type),
                  child: const Text('Networks', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              balance,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.2, end: 0);
  }

  void _showNetworkSelector(
    BuildContext context,
    String symbol,
    CryptoWallet wallet,
    String type,
  ) {
    final networks = CryptoNetwork.getStablecoinNetworks();

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$symbol Networks',
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.md),
            ...networks.map((network) {
              String? address;
              if (type == 'usdt') {
                address = network.code == 'ERC20'
                    ? wallet.usdtErc20Address
                    : network.code == 'BEP20'
                        ? wallet.usdtBep20Address
                        : wallet.usdtTrc20Address;
              } else {
                address = network.code == 'ERC20'
                    ? wallet.usdcErc20Address
                    : network.code == 'BEP20'
                        ? wallet.usdcBep20Address
                        : wallet.usdcTrc20Address;
              }

              return Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: network.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.link, color: network.color, size: 20),
                  ),
                  title:
                      Text(network.name, style: const TextStyle(fontSize: 14)),
                  subtitle: Text(
                    address ?? 'Not connected',
                    style: const TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: address != null
                      ? IconButton(
                          icon: const Icon(Icons.copy, size: 16),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: address!));
                            context.showSuccessSnackBar(
                                '${network.code} address copied!');
                          },
                        )
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    _showDepositDialog(context, '$symbol (${network.code})');
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showDepositDialog(BuildContext context, String currency) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Deposit $currency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Send crypto to this address:'),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: const Text(
                '0x742d35Cc6634C0532925a3b844Bc9e7595f0bEb',
                style: TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context, String currency) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Withdraw $currency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Address')),
            const SizedBox(height: AppSpacing.md),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.showSuccessSnackBar('Withdrawal initiated');
            },
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
  }

  CryptoWallet _getMockWallet() {
    final ethAddr = '0x742d35Cc6634C0532925a3b844Bc9e7595f0bEb';
    final bnbAddr = '0x8b3192f7C7F7C7F7C7F7C7F7C7F7C7F7C7F7C7F7';
    final tronAddr = 'TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t';

    return CryptoWallet(
      userId: 'user1',
      ethBalance: 0.0523,
      ccdBalance: 150.25,
      bnbBalance: 0.342,
      usdtBalance: 1250.50,
      usdcBalance: 850.00,
      ethAddress: ethAddr,
      ccdAddress: '4hXCdgmgjDeZYw6fKz8bGbqZ4TsVkVh8M9fqLUYs8',
      bnbAddress: bnbAddr,
      usdtErc20Address: ethAddr,
      usdtBep20Address: bnbAddr,
      usdtTrc20Address: tronAddr,
      usdcErc20Address: ethAddr,
      usdcBep20Address: bnbAddr,
      usdcTrc20Address: tronAddr,
    );
  }
}

class CurrencySwapScreen extends StatefulWidget {
  const CurrencySwapScreen({super.key});

  @override
  State<CurrencySwapScreen> createState() => _CurrencySwapScreenState();
}

class _CurrencySwapScreenState extends State<CurrencySwapScreen> {
  String _fromCurrency = 'NGN';
  String _toCurrency = 'USDT';
  final _amountController = TextEditingController();
  double _estimatedAmount = 0.0;

  final Map<String, double> _rates = {
    'NGN_ETH': 0.0000008,
    'ETH_NGN': 1250000,
    'NGN_BNB': 0.000003,
    'BNB_NGN': 333333,
    'NGN_USDT': 0.00064,
    'USDT_NGN': 1560,
    'NGN_USDC': 0.00064,
    'USDC_NGN': 1560,
    'NGN_CCD': 0.005,
    'CCD_NGN': 200,
  };

  final List<String> _currencies = ['NGN', 'ETH', 'BNB', 'CCD', 'USDT', 'USDC'];

  void _calculateSwap() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final rate = _rates['${_fromCurrency}_$_toCurrency'] ?? 0;
    setState(() {
      _estimatedAmount = amount * rate;
    });
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _calculateSwap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swap Currency')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // From
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('From', style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.00',
                          ),
                          style: context.textTheme.headlineSmall,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _calculateSwap(),
                        ),
                      ),
                      DropdownButton<String>(
                        value: _fromCurrency,
                        items: _currencies.map((currency) {
                          return DropdownMenuItem(
                              value: currency, child: Text(currency));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _fromCurrency = value!;
                            _calculateSwap();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(),

          const SizedBox(height: AppSpacing.md),

          // Swap button
          Center(
            child: IconButton(
              onPressed: _swapCurrencies,
              icon: const Icon(Icons.swap_vert),
              style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary.withOpacity(0.1)),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // To
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('To', style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _estimatedAmount
                              .toStringAsFixed(_toCurrency == 'NGN' ? 2 : 6),
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: _toCurrency,
                        items: _currencies.map((currency) {
                          return DropdownMenuItem(
                              value: currency, child: Text(currency));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _toCurrency = value!;
                            _calculateSwap();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 100.ms),

          const SizedBox(height: AppSpacing.xl),

          // Exchange rate
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text(
              'Rate: 1 $_fromCurrency = ${(_rates['${_fromCurrency}_$_toCurrency'] ?? 0).toStringAsFixed(_toCurrency == 'NGN' ? 2 : 8)} $_toCurrency',
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Swap button
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context.showSuccessSnackBar('Swap successful!');
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Swap Now'),
            ),
          ),
        ],
      ),
    );
  }
}
