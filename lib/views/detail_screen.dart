import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:github_explorer/view_models/repo_view_model.dart';
import 'package:github_explorer/views/widgets/border_widget.dart';

class DetailScreen extends ConsumerWidget {
  final String username;

  const DetailScreen(this.username, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repoState = ref.watch(repoViewModelProvider);

    return Scaffold(
      key: const Key('detail_screen'),
      appBar: AppBar(
        title: Text("$username's repositories"),
      ),
      body: repoState.when(
        data: (data) => ListView.separated(
          itemCount: data.length,
          separatorBuilder: (context, index) => const Divider(thickness: 4, height: 16),
          itemBuilder: (context, index) {
            final repo = data[index];
            return ListTile(
              title: Text(
                repo.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(repo.description ?? 'No description'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BorderWidget(text: '${repo.stargazersCount} stars'),
                  const Gap(8),
                  BorderWidget(text: repo.language),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stack) => ErrorWidget(e),
      ),
    );
  }
}
