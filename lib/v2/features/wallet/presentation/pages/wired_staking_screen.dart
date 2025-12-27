import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/savings_model.dart';
import '../../../../core/providers/repository_providers.dart';

// State Provider for Staking Data
final stakingDataProvider = FutureProvider<List<StakingPosition>>((ref) async {
  final repository = ref.watch(stakingRepositoryProvider);
  final result = await repository.getStakingPositions();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (positions) => positions,
  );
});

final stakingPoolsProvider = FutureProvider((ref) async {
  final repository = ref.watch(stakingRepositoryProvider);
  final result = await repository.getAvailablePools();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (pools) => pools,
  );
});

// Wired Staking Screen with Real Provider Integration
class WiredStakingScreen extends ConsumerStatefulWidget {
  const WiredStakingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WiredStakingScreen> createState() => _WiredStakingScreenState();
}

class _WiredStakingScreenState extends ConsumerState<WiredStakingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final stakingAsync = ref.watch(stakingDataProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Staking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () => _showCalculator(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My Stakes'),
            Tab(text: 'Pools'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyStakesTab(stakingAsync),
          _buildPoolsTab(),
          _buildHistoryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showStakeDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Stake Now'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildMyStakesTab(AsyncValue<List<StakingPosition>> stakingAsync) {
    return stakingAsync.when(
      data: (positions) {
        final totalStaked = positions.fold<int>(
          0,
          (sum, position) => sum + position.amount,
        );

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(stakingDataProvider);
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Total Staked Card
                _buildTotalStakedCard(totalStaked, positions.length),
                const SizedBox(height: 20),

                // Stakes List
                if (positions.isEmpty)
                  _buildEmptyState()
                else
                  ...positions.map((position) => _buildStakeCard(position)),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(error),
    );
  }

  Widget _buildTotalStakedCard(int total, int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppTheme.primaryShadow],
      ),
      child: Column(
        children: [
          Text(
            'Total Staked',
            style:
                TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '₦$total',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn('Positions', '$count'),
              _buildStatColumn('Avg APY', '15.5%'),
              _buildStatColumn('Rewards', '₦12K'),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Text(label,
            style:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
      ],
    );
  }

  Widget _buildStakeCard(StakingPosition position) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${position.daysRemaining}-Day Pool',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(position.amountFormatted,
                      style: TextStyle(
                          fontSize: 16, color: AppTheme.primaryColor)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('${position.apy}% APY',
                    style: const TextStyle(color: AppTheme.successColor)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Claim Rewards'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Unstake'),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildPoolsTab() => Center(child: Text('Available Pools'));
  Widget _buildHistoryTab() => Center(child: Text('Staking History'));
  Widget _buildEmptyState() => Center(child: Text('No stakes yet'));
  Widget _buildErrorState(Object error) => Center(child: Text('Error: $error'));

  void _showCalculator(BuildContext context) {}
  void _showStakeDialog(BuildContext context) {}
}
