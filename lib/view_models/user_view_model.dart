import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_explorer/models/github_user.dart';
import 'package:github_explorer/services/github_service.dart';

class UserViewModelNotifier extends AsyncNotifier<List<GitHubUser>> {
  final GitHubService _gitHubService = GitHubService();

  @override
  FutureOr<List<GitHubUser>> build() async {
    return [];
  }

  Future<void> fetchUsers(int since, int perPage) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _gitHubService.fetchUsers(since, perPage);
    });
  }

  Future<void> loadMoreUsers(int since) async {
    state = await AsyncValue.guard(() async {
      return [...state.value ?? [], ...await _gitHubService.fetchUsers(since, 20)];
    });
  }
}

final userViewModelProvider = AsyncNotifierProvider<UserViewModelNotifier, List<GitHubUser>>(UserViewModelNotifier.new);
