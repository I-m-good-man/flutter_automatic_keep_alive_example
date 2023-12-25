import 'package:app_navigation_recalling/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerDelegate: AppNavigation.routerDelegate(ref: ref),
      routeInformationParser: AppNavigation.routeInformationParser,
    );
  }
}
