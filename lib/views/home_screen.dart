import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_explorer/providers/theme_provider.dart';
import 'package:github_explorer/view_models/repo_view_model.dart';
import 'package:github_explorer/view_models/user_view_model.dart';
import 'package:github_explorer/views/widgets/ad_banner.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _since = 0;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    Future(() => ref.read(userViewModelProvider.notifier).fetchUsers(0, 20));
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_isLoadingMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() {
      _isLoadingMore = true;
    });
    final userState = ref.read(userViewModelProvider.notifier);
    await userState.loadMoreUsers(_since);
    _since += 20;
    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Github Explorer"),
        centerTitle: true,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final isDark = ref.watch(themeProvider) == ThemeMode.dark;
              return IconButton(
                  onPressed: () =>
                      ref.read(themeProvider.notifier).update((state) => isDark ? ThemeMode.light : ThemeMode.dark),
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode));
            },
          ),
        ],
      ),
      body: userState.when(
        data: (data) => Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: data.length + (data.length ~/ 10),
            itemBuilder: (context, index) {
              if (index % 10 == 9) {
                return const AdBanner();
              }
              final user = data[index - (index ~/ 10)];
              return Card(
                child: ListTile(
                  key: Key('user_list_tile_${index - (index ~/ 10)}'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      user.avatarUrl,
                      errorListener: (p0) => const Text('error'),
                    ),
                  ),
                  title: Text(user.login),
                  onTap: () {
                    ref.read(repoViewModelProvider.notifier).fetchRepos(user.login);
                    context.push('/detail/${user.login}');
                  },
                ),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stack) => ErrorWidget(e),
      ),
    );
  }
}
