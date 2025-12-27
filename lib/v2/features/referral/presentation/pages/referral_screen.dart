import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/models/messaging_model.dart';

class ReferralScreen extends ConsumerWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final referral = _getMockReferral();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Referral Program'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Earnings card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Column(
              children: [
                Text(
                  'Total Earnings',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  referral.earningsFormatted,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${referral.totalReferrals} friends referred',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 12),
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: -0.2, end: 0),

          const SizedBox(height: AppSpacing.xl),

          // Referral code card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Referral Code',
                    style: context.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border:
                          Border.all(color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          referral.referralCode,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            letterSpacing: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: referral.referralCode));
                            context.showSuccessSnackBar('Code copied!');
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Share.share(
                          'Join Gonana with my referral code ${referral.referralCode} and earn rewards!',
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share Code'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 100.ms),

          const SizedBox(height: AppSpacing.xl),

          // How it works
          Text(
            'How It Works',
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildStep(
              '1', 'Share your code', 'Send your referral code to friends'),
          _buildStep(
              '2', 'Friend signs up', 'They create account with your code'),
          _buildStep('3', 'Earn rewards', 'Get ₦500 per successful referral'),

          const SizedBox(height: AppSpacing.xl),

          // Referred users
          if (referral.referredUsers.isNotEmpty) ...[
            Text(
              'Referred Friends',
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.md),
            ...referral.referredUsers
                .map((user) => _buildReferredUserCard(user)),
          ],
        ],
      ),
    );
  }

  Widget _buildStep(String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.2, end: 0);
  }

  Widget _buildReferredUserCard(ReferredUser user) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name[0])),
        title: Text(user.name),
        subtitle: Text(
            'Joined ${user.joinedAt.day}/${user.joinedAt.month}/${user.joinedAt.year}'),
        trailing: Text(
          '+₦${user.earnings}',
          style:
              TextStyle(color: AppColors.success, fontWeight: FontWeight.w600),
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.2, end: 0);
  }

  Referral _getMockReferral() {
    return Referral(
      id: '1',
      userId: 'user1',
      referralCode: 'GONANA2024',
      totalReferrals: 5,
      totalEarnings: 2500,
      referredUsers: [
        ReferredUser(
          name: 'Jane Doe',
          joinedAt: DateTime.now().subtract(const Duration(days: 5)),
          earnings: 500,
        ),
        ReferredUser(
          name: 'Mike Smith',
          joinedAt: DateTime.now().subtract(const Duration(days: 10)),
          earnings: 500,
        ),
      ],
    );
  }
}
