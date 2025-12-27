import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/post_repository.dart';
import '../../../../core/models/post_model.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

final postsProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) {
  return PostsNotifier(ref.read(postRepositoryProvider));
});

class PostsState {
  final List<Post> posts;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? error;

  PostsState({
    this.posts = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 1,
    this.error,
  });

  PostsState copyWith({
    List<Post>? posts,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? error,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      error: error,
    );
  }
}

class PostsNotifier extends StateNotifier<PostsState> {
  final PostRepository _repository;

  PostsNotifier(this._repository) : super(PostsState()) {
    loadPosts();
  }

  Future<void> loadPosts({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      state = PostsState(isLoading: true);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    final page = refresh ? 1 : state.currentPage;
    final result = await _repository.getPosts(page: page);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (newPosts) {
        final posts = refresh ? newPosts : [...state.posts, ...newPosts];
        state = state.copyWith(
          posts: posts,
          isLoading: false,
          hasMore: newPosts.length >= 15,
          currentPage: page + 1,
          error: null,
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading) return;
    await loadPosts();
  }

  Future<void> refresh() => loadPosts(refresh: true);

  Future<bool> likePost(String postId) async {
    final result = await _repository.likePost(postId);

    return result.fold(
      (failure) => false,
      (success) {
        // Update local state
        final updatedPosts = state.posts.map((post) {
          if (post.id == postId) {
            return Post(
              id: post.id,
              userId: post.userId,
              authorName: post.authorName,
              authorImage: post.authorImage,
              content: post.content,
              images: post.images,
              likesCount: post.likesCount + 1,
              commentsCount: post.commentsCount,
              isLiked: true,
              createdAt: post.createdAt,
            );
          }
          return post;
        }).toList();

        state = state.copyWith(posts: updatedPosts);
        return true;
      },
    );
  }

  Future<bool> unlikePost(String postId) async {
    final result = await _repository.unlikePost(postId);

    return result.fold(
      (failure) => false,
      (success) {
        // Update local state
        final updatedPosts = state.posts.map((post) {
          if (post.id == postId) {
            return Post(
              id: post.id,
              userId: post.userId,
              authorName: post.authorName,
              authorImage: post.authorImage,
              content: post.content,
              images: post.images,
              likesCount: post.likesCount - 1,
              commentsCount: post.commentsCount,
              isLiked: false,
              createdAt: post.createdAt,
            );
          }
          return post;
        }).toList();

        state = state.copyWith(posts: updatedPosts);
        return true;
      },
    );
  }
}
