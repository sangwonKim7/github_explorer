import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_explorer/core/theme/theme.dart';
import 'package:github_explorer/providers/theme_provider.dart';
import 'package:github_explorer/routers/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling), // 폰트 크기 고정
      child: Consumer(
        builder: (context, ref, child) => MaterialApp.router(
          title: 'Github Explorer',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ref.watch(themeProvider),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
