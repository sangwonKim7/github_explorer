import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_explorer/models/github_repo.dart';
import 'package:github_explorer/services/github_service.dart';

class RepoViewModelNotifier extends AsyncNotifier<List<GithubRepo>> {
  final GitHubService _gitHubService = GitHubService();

  @override
  FutureOr<List<GithubRepo>> build() {
    return [];
  }

  Future<void> fetchRepos(String username) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _gitHubService.fetchRepos(username);
    });
  }
}

final repoViewModelProvider = AsyncNotifierProvider<RepoViewModelNotifier, List<GithubRepo>>(RepoViewModelNotifier.new);
