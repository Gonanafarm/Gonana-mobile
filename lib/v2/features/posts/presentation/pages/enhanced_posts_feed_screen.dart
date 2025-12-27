import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/post_model.dart';

// Enhanced Posts Feed with Trending, Categories, and Advanced Engagement
class EnhancedPostsFeedScreen extends ConsumerStatefulWidget {
  const EnhancedPostsFeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EnhancedPostsFeedScreen> createState() =>
      _EnhancedPostsFeedScreenState();
}

class _EnhancedPostsFeedScreenState
    extends ConsumerState<EnhancedPostsFeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilters(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'For You'),
            Tab(text: 'Trending'),
            Tab(text: 'Following'),
            Tab(text: 'Marketplace'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Category Chips
          _buildCategoryChips(),

          // Posts Feed
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildForYouFeed(),
                _buildTrendingFeed(),
                _buildFollowingFeed(),
                _buildMarketplaceFeed(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePost(),
        icon: const Icon(Icons.add),
        label: const Text('Post'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = ['all', 'farming', 'tech', 'business', 'news', 'tips'];

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;

          return FilterChip(
            label: Text(
              category == 'all' ? 'All' : '#${category}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            selected: isSelected,
            onSelected: (selected) {
              setState(() => _selectedCategory = category);
            },
            backgroundColor: AppTheme.cardColor,
            selectedColor: AppTheme.primaryColor.withOpacity(0.2),
            checkmarkColor: AppTheme.primaryColor,
          );
        },
      ),
    );
  }

  Widget _buildForYouFeed() {
    // Mock posts
    final posts = List.generate(10, (index) => _buildMockPost(index));

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: posts.length,
        itemBuilder: (context, index) => posts[index],
      ),
    );
  }

  Widget _buildMockPost(int index) {
    final hasImage = index % 3 == 0;
    final hasMultipleImages = index % 5 == 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                child: Text(
                  'U${index + 1}',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User ${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${index + 1}h ago',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showPostOptions(),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Post Content
          Text(
            'This is an enhanced post #${index + 1} with better UI, trending support, and engagement features! 🚀',
            style: const TextStyle(
              fontSize: 15,
              height: 1.4,
            ),
          ),

          if (hasImage) ...[
            const SizedBox(height: 12),
            if (hasMultipleImages)
              _buildImageCarousel()
            else
              _buildSingleImage(),
          ],

          const SizedBox(height: 16),

          // Engagement Stats
          Row(
            children: [
              Text(
                '${125 + index * 10} likes',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${12 + index} comments',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${5 + index} shares',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(
                  Icons.favorite_border, 'Like', AppTheme.errorColor),
              _buildActionButton(
                  Icons.comment_outlined, 'Comment', AppTheme.primaryColor),
              _buildActionButton(
                  Icons.share_outlined, 'Share', AppTheme.successColor),
              _buildActionButton(Icons.bookmark_border, 'Save', Colors.amber),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1, delay: (index * 50).ms);
  }

  Widget _buildImageCarousel() {
    return Container(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 280,
              color: Colors.grey[300],
              child: Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSingleImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 200,
        color: Colors.grey[300],
        child: Center(
          child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingFeed() {
    return Center(child: Text('Trending Posts'));
  }

  Widget _buildFollowingFeed() {
    return Center(child: Text('Following Feed'));
  }

  Widget _buildMarketplaceFeed() {
    return Center(child: Text('Marketplace Posts'));
  }

  void _showSearch() {}
  void _showFilters() {}
  void _showCreatePost() {}
  void _showPostOptions() {}
}
