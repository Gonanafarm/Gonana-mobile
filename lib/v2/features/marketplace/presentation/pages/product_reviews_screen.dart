import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/models/review_model.dart';

class ProductReviewsScreen extends ConsumerWidget {
  final String productId;
  final String productName;

  const ProductReviewsScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock reviews - in production, fetch from repository
    final reviews = _getMockReviews();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: Column(
        children: [
          // Overall rating
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            color:
                context.isDarkMode ? AppColors.surfaceLight : Colors.grey[100],
            child: Column(
              children: [
                Text(
                  _calculateAverageRating(reviews).toStringAsFixed(1),
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                _buildStars(_calculateAverageRating(reviews)),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${reviews.length} reviews',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms),

          // Reviews list
          Expanded(
            child: reviews.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.rate_review_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'No reviews yet',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Be the first to review this product!',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: reviews.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: AppSpacing.lg * 2,
                    ),
                    itemBuilder: (context, index) {
                      return _buildReviewCard(context, reviews[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddReviewDialog(context),
        icon: const Icon(Icons.rate_review),
        label: const Text('Write Review'),
        backgroundColor: AppColors.primary,
      ).animate().scale(delay: 300.ms),
    );
  }

  Widget _buildReviewCard(BuildContext context, ProductReview review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: review.userImage != null
                  ? NetworkImage(review.userImage!)
                  : null,
              child: review.userImage == null
                  ? Text(review.userName[0].toUpperCase())
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  _buildStars(review.rating.toDouble(), size: 16),
                ],
              ),
            ),
            Text(
              review.createdAt.formatDate,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        if (review.comment != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(review.comment!),
        ],
      ],
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildStars(double rating, {double size = 24}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : (index < rating ? Icons.star_half : Icons.star_border),
          color: Colors.amber,
          size: size,
        );
      }),
    );
  }

  double _calculateAverageRating(List<ProductReview> reviews) {
    if (reviews.isEmpty) return 0;
    return reviews.map((r) => r.rating).reduce((a, b) => a + b) /
        reviews.length;
  }

  void _showAddReviewDialog(BuildContext context) {
    int selectedRating = 5;
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Write a Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Rate $productName'),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() => selectedRating = index + 1);
                    },
                    icon: Icon(
                      index < selectedRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  labelText: 'Your review (optional)',
                  hintText: 'Share your experience...',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Submit review to repository
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Review submitted!')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  List<ProductReview> _getMockReviews() {
    return [
      ProductReview(
        id: '1',
        productId: productId,
        userId: 'user1',
        userName: 'John Doe',
        rating: 5,
        comment: 'Excellent product! Fresh and high quality.',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ProductReview(
        id: '2',
        productId: productId,
        userId: 'user2',
        userName: 'Jane Smith',
        rating: 4,
        comment: 'Good value for money. Fast delivery.',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }
}
