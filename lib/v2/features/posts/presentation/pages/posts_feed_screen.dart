import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../providers/posts_provider.dart';

class PostsFeedScreen extends ConsumerStatefulWidget {
  const PostsFeedScreen({super.key});

  @override
  ConsumerState<PostsFeedScreen> createState() => _PostsFeedScreenState();
}

class _PostsFeedScreenState extends ConsumerState<PostsFeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(postsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final postsState = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // TODO: Navigate to create post
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(postsProvider.notifier).refresh(),
        child: postsState.posts.isEmpty && postsState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                itemCount:
                    postsState.posts.length + (postsState.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= postsState.posts.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.lg),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final post = postsState.posts[index];
                  return _buildPostCard(post);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create post
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPostCard(post) {
    return Card(
      margin: const EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        bottom: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: post.authorImage != null
                  ? CachedNetworkImageProvider(post.authorImage!)
                  : null,
              child: post.authorImage == null
                  ? Text(post.authorName?.substring(0, 1).toUpperCase() ?? 'U')
                  : null,
            ),
            title: Text(
              post.authorName ?? 'Anonymous',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(post.createdAt.formatDateTime),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // TODO: Show post options
              },
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              post.content,
              style: const TextStyle(fontSize: 15),
            ),
          ),

          // Images
          if (post.images.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            post.images.length == 1
                ? CachedNetworkImage(
                    imageUrl: post.images[0],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                    ),
                    items: post.images.map((url) {
                      return CachedNetworkImage(
                        imageUrl: url,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  ),
          ],

          const SizedBox(height: AppSpacing.sm),

          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Text(
                  '${post.likesCount} ${post.likesCount == 1 ? 'like' : 'likes'}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  '${post.commentsCount} ${post.commentsCount == 1 ? 'comment' : 'comments'}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),

          const Divider(height: AppSpacing.md),

          // Actions
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    if (post.isLiked) {
                      ref.read(postsProvider.notifier).unlikePost(post.id);
                    } else {
                      ref.read(postsProvider.notifier).likePost(post.id);
                    }
                  },
                  icon: Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: post.isLiked ? AppColors.error : null,
                  ),
                  label: Text(
                    'Like',
                    style: TextStyle(
                      color: post.isLiked ? AppColors.error : null,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    // TODO: Navigate to post details
                  },
                  icon: const Icon(Icons.comment_outlined),
                  label: const Text('Comment'),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    // TODO: Share post
                  },
                  icon: const Icon(Icons.share_outlined),
                  label: const Text('Share'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
