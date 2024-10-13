import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:juego_pares/config/router/app_router.dart';
import 'package:juego_pares/config/theme/app_theme.dart';
import 'package:juego_pares/presentation/providers/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp()
    )
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final AppTheme appTheme = ref.watch( themeNotifierProvider );

    return MaterialApp.router(
      title: 'Juego de Pares',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
    );
  }
}