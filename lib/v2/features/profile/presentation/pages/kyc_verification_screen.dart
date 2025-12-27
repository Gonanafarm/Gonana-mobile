import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/models/bank_model.dart';
import '../../../../core/services/crypto_address_generator.dart';

class KYCVerificationScreen extends ConsumerWidget {
  const KYCVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock KYC status - would come from provider
    final kycStatus = KYCStatus(
      bvnVerified: false,
      idCardVerified: false,
      selfieVerified: false,
      tier: 1,
      walletActivated: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('KYC Verification'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Status card
          _buildStatusCard(context, kycStatus),

          const SizedBox(height: AppSpacing.lg),

          // Tier benefits
          if (!kycStatus.walletActivated) _buildTierBenefitsCard(context),

          const SizedBox(height: AppSpacing.lg),

          // Verification steps
          _buildVerificationStep(
            context,
            'BVN Verification',
            'Verify your Bank Verification Number',
            kycStatus.bvnVerified,
            Icons.badge,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BVNVerificationScreen()),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          _buildVerificationStep(
            context,
            'ID Card Upload',
            'Upload your National ID, Passport, or Driver\'s License',
            kycStatus.idCardVerified,
            Icons.credit_card,
            () => _showDocumentUpload(context, 'id_card'),
          ),

          const SizedBox(height: AppSpacing.md),

          _buildVerificationStep(
            context,
            'Selfie Verification',
            'Take a selfie for verification',
            kycStatus.selfieVerified,
            Icons.face,
            () => _showDocumentUpload(context, 'selfie'),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Current tier limits
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.info.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.info, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Current Tier: ${kycStatus.tierName}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  kycStatus.tierDescription,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                if (kycStatus.tier >= 2) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '• Daily Limit: ₦${kycStatus.dailyLimit.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    '• Monthly Limit: ₦${kycStatus.monthlyLimit.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ],
            ),
          ),

          // Wallet activation status
          if (kycStatus.isFullyVerified && !kycStatus.walletActivated) ...[
            const SizedBox(height: AppSpacing.xl),
            _buildActivateWalletButton(context, kycStatus),
          ],

          // Wallet details (after activation)
          if (kycStatus.walletActivated) ...[
            const SizedBox(height: AppSpacing.xl),
            _buildWalletDetailsCard(context, kycStatus),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, KYCStatus status) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verification Level',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(height: 4),
                    Text(
                      status.tierName,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: status.walletActivated
                            ? AppColors.success
                            : AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: status.completionPercentage / 100,
                        strokeWidth: 6,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          status.walletActivated
                              ? AppColors.success
                              : AppColors.primary,
                        ),
                      ),
                    ),
                    Text(
                      '${status.completionPercentage}%',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            if (status.walletActivated) ...[
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle,
                        color: AppColors.success, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Wallet Activated',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildTierBenefitsCard(BuildContext context) {
    return Card(
      color: AppColors.primary.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                const Text('Unlock Your Wallet',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Complete KYC to activate:',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildBenefit('Naira wallet & account number'),
            _buildBenefit('Crypto wallets (ETH & CCD)'),
            _buildBenefit('P2P transfers'),
            _buildBenefit('Savings & Staking'),
            _buildBenefit('Bank transfers'),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 100.ms);
  }

  Widget _buildBenefit(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: AppColors.success),
          const SizedBox(width: AppSpacing.xs),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildVerificationStep(
    BuildContext context,
    String title,
    String description,
    bool isVerified,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: isVerified
                ? AppColors.success.withOpacity(0.1)
                : AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon,
              color: isVerified ? AppColors.success : AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(description, style: const TextStyle(fontSize: 12)),
        trailing: isVerified
            ? Icon(Icons.check_circle, color: AppColors.success)
            : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: isVerified ? null : onTap,
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildActivateWalletButton(BuildContext context, KYCStatus status) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () => _activateWallet(context, status),
        icon: const Icon(Icons.account_balance_wallet),
        label: const Text('Activate Wallet Now'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildWalletDetailsCard(BuildContext context, KYCStatus status) {
    return Card(
      color: AppColors.success.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet, color: AppColors.success),
                const SizedBox(width: AppSpacing.sm),
                const Text('Your Wallet Details',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            const Divider(),
            _buildWalletDetail('Naira Account', status.accountNumber ?? 'N/A'),
            _buildWalletDetail('ETH Address', _maskAddress(status.ethAddress)),
            _buildWalletDetail('CCD Address', _maskAddress(status.ccdAddress)),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildWalletDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          Text(value,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _maskAddress(String? address) {
    if (address == null) return 'N/A';
    if (address.length <= 10) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  void _activateWallet(BuildContext context, KYCStatus status) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Simulate wallet activation
    await Future.delayed(const Duration(seconds: 2));

    // Generate addresses
    final addresses =
        CryptoAddressGenerator.instance.generateAllCryptoAddresses();
    final accountNumber = _generateAccountNumber();

    // In production, send to backend
    // await walletRepository.activateWallet(addresses, accountNumber);

    if (context.mounted) {
      Navigator.pop(context); // Close loading

      // Show success
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success),
              const SizedBox(width: AppSpacing.sm),
              const Text('Wallet Activated!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your accounts have been created:'),
              const SizedBox(height: AppSpacing.md),
              Text('Account: $accountNumber',
                  style: const TextStyle(fontSize: 12)),
              Text('ETH: ${_maskAddress(addresses['eth'])}',
                  style: const TextStyle(fontSize: 12)),
              Text('CCD: ${_maskAddress(addresses['ccd'])}',
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Great!'),
            ),
          ],
        ),
      );
    }
  }

  String _generateAccountNumber() {
    // Generate 10-digit account number
    return List.generate(
        10,
        (i) => (i == 0
            ? '123456789'
            : '0123456789')[DateTime.now().millisecond % 10]).join();
  }

  void _showDocumentUpload(BuildContext context, String type) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null && context.mounted) {
      context.showSuccessSnackBar(
          '${type == 'selfie' ? 'Selfie' : 'Document'} uploaded for verification');
    }
  }
}

// Keep existing BVNVerificationScreen unchanged...
class BVNVerificationScreen extends StatefulWidget {
  const BVNVerificationScreen({super.key});

  @override
  State<BVNVerificationScreen> createState() => _BVNVerificationScreenState();
}

class _BVNVerificationScreenState extends State<BVNVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bvnController = TextEditingController();
  bool _isVerifying = false;

  @override
  void dispose() {
    _bvnController.dispose();
    super.dispose();
  }

  Future<void> _verifyBVN() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isVerifying = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isVerifying = false);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('BVN verified successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BVN Verification')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text('Enter your BVN',
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.sm),
            Text(
                'Your Bank Verification Number is required for identity verification and compliance.',
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: AppSpacing.xl),
            TextFormField(
              controller: _bvnController,
              decoration: const InputDecoration(
                labelText: 'BVN *',
                hintText: '12345678901',
                prefixIcon: Icon(Icons.badge),
              ),
              keyboardType: TextInputType.number,
              maxLength: 11,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter your BVN';
                if (value.length != 11) return 'BVN must be 11 digits';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lock_outline, color: AppColors.info, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                        'Your BVN is encrypted and secure. We use it only for verification purposes.',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isVerifying ? null : _verifyBVN,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                child: _isVerifying
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Verify BVN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
