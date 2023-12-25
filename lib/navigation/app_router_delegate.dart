import 'package:app_navigation_recalling/navigation/app_path.dart';
import 'package:app_navigation_recalling/navigation/app_route_config.dart';
import 'package:app_navigation_recalling/pages/home_page.dart';
import 'package:app_navigation_recalling/pages/undefined_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/launch_page.dart';

class AppRouterDelegate extends RouterDelegate<AppRouteConfig>
    with PopNavigatorRouterDelegateMixin, ChangeNotifier {
  final WidgetRef ref;
  final NavigationProvider _navigationProvider;

  AppRouterDelegate({required this.ref})
      : _navigationProvider = navigationProvider {
    ref.listen(_navigationProvider, (previous, next) {
      notifyListeners();
    });
  }

  @override
  Future<void> setInitialRoutePath(AppRouteConfig configuration) async {}

  @override
  Future<void> setNewRoutePath(AppRouteConfig configuration) async {
    ref
        .read(_navigationProvider.notifier)
        .setRouteConfig(routeConfig: configuration.routeConfig);
  }

  @override
  AppRouteConfig get currentConfiguration {
    return ref.read(_navigationProvider);
  }

  @override
  Future<bool> popRoute() async {
    super.popRoute();
    if (currentConfiguration.routeConfig.length > 1) {
      ref.read(_navigationProvider.notifier).popRoute();
    }
    return true;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey {
    return GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
      key: navigatorKey,
      pages: [
        for (AppPath appPath in currentConfiguration.routeConfig)
          MaterialPage(
              child: switch (appPath.runtimeType) {
            LaunchPath => LaunchPage(),
            HomePath => HomePage(),
            UndefinedPath => UndefinedPage(),
            _ => throw Exception('Unintentional AppPath in Navigator.pages')
          })
      ],
    );
  }
}
