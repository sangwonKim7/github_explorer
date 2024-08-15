import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_explorer/view_models/user_view_model.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Github Explorer"),
        centerTitle: true,
      ),
      body: userState.when(
        data: (data) => ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            final user = data[index - (index ~/ 10)];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
              ),
              title: Text(user.login),
              onTap: () {
                context.push('/detail');
              },
            );
          },
        ),
        error: (e, stack) => Center(child: Text('Error: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
