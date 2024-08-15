import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_explorer/view_models/repo_view_model.dart';

class DetailScreen extends ConsumerWidget {
  final String username;

  const DetailScreen(this.username, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repoState = ref.watch(repoViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("$username's repositories"),
      ),
      body: repoState.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final repo = data[index];
            return ListTile(
              title: Text(repo.name),
              subtitle: Text(repo.description ?? 'No description'),
              trailing: Text('${repo.stargazersCount} stars'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stack) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
