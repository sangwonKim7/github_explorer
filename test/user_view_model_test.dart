import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/core/utils/logger.dart';
import 'package:github_explorer/view_models/user_view_model.dart';

/// - Start Debugging (F5)
void main() {
  late ProviderContainer container;

  group('user_view_model_test', () {
    setUp(() {
      logger.d('##### setUp started!');
      container = ProviderContainer();
    });

    tearDown(() {
      logger.d('##### tearDown started!');
      container.dispose();
    });

    test('사용자 목록(20개)을 가져온다', () async {
      logger.d('##### 사용자 목록(20개)을 가져온다 started!');

      // 초기 유저 목록(20) 가져오기
      await container.read(userViewModelProvider.notifier).build();
      await container.read(userViewModelProvider.notifier).fetchUsers(0, 20);
      final result = container.read(userViewModelProvider);

      logger.d("AsyncValue: $result");
      logger.d("Data length: ${result.value?.length}");
      expect(result.hasValue, equals(true));
      expect(result.value?.length, equals(20));
    });

    test('사용자 목록(초기 20개)을 불러온 후, 목록(20개)을 추가로 불러온다', () async {
      logger.d('##### 사용자 목록(초기 20개)을 불러온 후, 목록(20개)을 추가로 불러온다 started!');

      // 초기 유저 목록(20) 가져오기
      await container.read(userViewModelProvider.notifier).build();
      await container.read(userViewModelProvider.notifier).fetchUsers(0, 20);
      final result1 = container.read(userViewModelProvider);
      logger.d(result1.value?.length);

      // 유저 목록(20) 추가로 가져오기
      await container.read(userViewModelProvider.notifier).loadMoreUsers(20);
      final result = container.read(userViewModelProvider);
      logger.d("##### AsyncValue: $result");
      logger.d("##### UserData length: ${result.value?.length}");
      expect(result.hasValue, equals(true));
      expect(result.value?.length, equals(40));
    });
  });
}
