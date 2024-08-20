import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/core/utils/logger.dart';
import 'package:github_explorer/view_models/repo_view_model.dart';
import 'package:github_explorer/view_models/user_view_model.dart';

/// - Start Debugging (F5)
void main() {
  late ProviderContainer container;

  group('repo_view_model_test', () {
    setUp(() {
      logger.d('##### setUp started!');
      container = ProviderContainer();
    });

    tearDown(() {
      logger.d('##### tearDown started!');
      container.dispose();
    });

    test('사용자 목록(20개)을 가져온 후, 첫번째 유저의 레포지토리 목록을 가져온다.', () async {
      logger.d('##### 사용자 목록(20개)을 가져온 후, 첫번째 유저의 레포지토리 목록을 가져온다. started!');

      // 초기 유저 목록(20) 가져오기
      await container.read(userViewModelProvider.notifier).build();
      await container.read(userViewModelProvider.notifier).fetchUsers(0, 20);
      final username = container.read(userViewModelProvider).value?.first.login;

      // 첫번째 유저의 레포지토리 목록 가져오기
      await container.read(repoViewModelProvider.notifier).build();
      await container.read(repoViewModelProvider.notifier).fetchRepos(username ?? "");
      final result = container.read(repoViewModelProvider);

      logger.d("##### AsyncValue: $result");
      logger.d("##### RepoData length: ${result.value?.length}");
      expect(result.hasValue, equals(true));
    });
  });
}
