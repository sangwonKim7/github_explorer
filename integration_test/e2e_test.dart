import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:github_explorer/main.dart' as app;

/// - 시뮬레이터 실행 or 터미널에서 명령어 실행(open -a Simulator.app)
/// - 터미널에서 아래 명령어 중 한가지 실행
/// flutter test integration_test/e2e_test.dart
/// flutter test integration_test/e2e_test.dart --name e2e_test
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('e2e_test', () {
    testWidgets('전체 시나리오 테스트', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 홈화면 로드 확인
      expect(find.byKey(const Key('home_screen')), findsOneWidget);

      // 홈화면 유저 listView 의 [마지막] item이 보일 때까지 스크롤 down
      await tester.dragUntilVisible(
        find.byType(ListTile).last,
        find.byType(ListView),
        const Offset(0, -80),
      );
      await tester.pumpAndSettle();

      // 홈화면 유저 목록이 추가된 이후
      // 홈화면 마지막 유저 리스트타일 확인
      expect(find.byType(ListTile).last, findsOneWidget);

      // 홈화면 유저 listView 의 [첫번째] item이 보일 때까지 스크롤 up
      await tester.dragUntilVisible(
        find.byType(ListTile).first,
        find.byType(ListView),
        const Offset(0, 80),
      );
      await tester.pumpAndSettle();

      // ============================================================ \\
      // 홈화면 유저 listView 의 [35번째(index:34)] item이 보일 때까지 스크롤 down
      final Finder item34 = find.byKey(const Key('user_list_tile_34'));
      await tester.dragUntilVisible(
        item34,
        find.byType(ListView),
        const Offset(0, -80),
      );
      await tester.pumpAndSettle();

      // 홈화면 item(index:34) 확인
      expect(item34, findsOneWidget);

      // item(index:34) 클릭
      await tester.tap(item34);
      await tester.pumpAndSettle();
      // ============================================================ //

      // 상세화면 로드 확인
      expect(find.byKey(const Key('detail_screen')), findsOneWidget);

      // 상세화면 레포 listView 의 [마지막] item이 보일 때까지 스크롤 down
      await tester.dragUntilVisible(
        find.byType(ListTile).last,
        find.byType(ListView),
        const Offset(0, -80),
      );
      await tester.pumpAndSettle();

      // 상세화면 레포 listView 의 [첫번째] item이 보일 때까지 스크롤 up
      await tester.dragUntilVisible(
        find.byType(ListTile).first,
        find.byType(ListView),
        const Offset(0, 80),
      );
      await tester.pumpAndSettle();

      // 뒤로가기 (홈화면으로)
      await tester.pageBack();
      await tester.pumpAndSettle();

      // 홈화면 로드 확인
      expect(find.byKey(const Key('home_screen')), findsOneWidget);

      // ============================================================ \\
      // 홈화면 유저 listView 의 [3번째(index:2)]이 보일 때까지 스크롤 up
      final Finder item2 = find.byKey(const Key('user_list_tile_2'));
      await tester.dragUntilVisible(
        item2,
        find.byType(ListView),
        const Offset(0, 80),
      );
      await tester.pumpAndSettle();

      // 홈화면 item(index:2) 확인
      expect(item2, findsOneWidget);

      // item(index:2)을 찾고 클릭
      await tester.tap(item2);
      await tester.pumpAndSettle();
      // ============================================================ //

      // 상세화면 로드 확인
      expect(find.byKey(const Key('detail_screen')), findsOneWidget);
    });
  });
}
