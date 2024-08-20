import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/main.dart' as app;
import 'package:integration_test/integration_test.dart';

/// - 시뮬레이터 실행 or 터미널에서 명령어 실행(open -a Simulator.app)
/// - 터미널에서 아래 명령어 중 한가지 실행
/// flutter test integration_test/integration_test.dart
/// flutter test integration_test/integration_test.dart --name integration_test
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('integration_test', () {
    testWidgets('화면이동 간단 테스트', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 홈화면 로드 확인
      expect(find.byKey(const Key('home_screen')), findsOneWidget);
      expect(find.text('Github Explorer'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // 첫번째 유저 탭
      expect(find.byKey(const Key('user_list_tile_0')), findsOneWidget);
      // await tester.tap(find.byType(ListTile).first);
      await tester.tap(find.byKey(const Key('user_list_tile_0')));
      await tester.pumpAndSettle();

      // 상세화면 확인
      expect(find.byKey(const Key('detail_screen')), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // 뒤로가기
      await tester.pageBack();
      await tester.pumpAndSettle();

      // 홈화면 로드 확인
      expect(find.byKey(const Key('home_screen')), findsOneWidget);
      expect(find.text('Github Explorer'), findsOneWidget);
    });

    testWidgets('홈UI (스크롤링 + 유저목록추가) > 화면이동 > 상세UI (스크롤링) 테스트', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 홈화면 로드 확인
      expect(find.byKey(const Key('home_screen')), findsOneWidget);
      expect(find.text('Github Explorer'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // 홈화면 유저 listView 의 [마지막] item이 보일 때까지 스크롤 down
      await tester.dragUntilVisible(
        find.byType(ListTile).last,
        find.byType(ListView),
        const Offset(0, -80),
      );
      await tester.pumpAndSettle();

      // 홈화면 유저 목록이 추가된 이후
      // 홈화면 유저 listView 의 [마지막] item이 보일 때까지 스크롤 down
      await tester.dragUntilVisible(
        find.byType(ListTile).last,
        find.byType(ListView),
        const Offset(0, -80),
      );
      await tester.pumpAndSettle();

      // 홈화면 마지막 유저 리스트타일 확인
      expect(find.byType(ListTile).last, findsOneWidget);

      // ============================================================ \\
      // user_listView의 15번째(index:14) item이 보일 때까지 스크롤 up
      final Finder item14 = find.byKey(const Key('user_list_tile_14'));
      await tester.dragUntilVisible(
        item14,
        find.byType(ListView),
        const Offset(0, 80),
      );
      await tester.pumpAndSettle();

      // 홈화면 item(index:14) 확인
      expect(item14, findsOneWidget);

      // item(index:14) 클릭
      await tester.tap(item14);
      await tester.pumpAndSettle();
      // ============================================================ //

      // 상세화면 로드 확인
      expect(find.byKey(const Key('detail_screen')), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsWidgets);

      // 뒤로가기 (홈화면으로)
      await tester.pageBack();
      await tester.pumpAndSettle();

      // 홈화면 로드 확인
      expect(find.byKey(const Key('home_screen')), findsOneWidget);
      expect(find.text('Github Explorer'), findsOneWidget);
    });
  });
}
