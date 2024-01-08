import 'package:app_navigation_recalling/navigation/app_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRouteConfig {
  final List<AppPath> routeConfig;

  const AppRouteConfig({required this.routeConfig});

  AppRouteConfig copyWith({
    List<AppPath>? routeConfig,
  }) {
    return AppRouteConfig(
      routeConfig: routeConfig ?? this.routeConfig,
    );
  }
}

class AppRouteConfigStateNotifier extends StateNotifier<AppRouteConfig> {
  AppRouteConfigStateNotifier({required AppRouteConfig state}) : super(state);

  void setRouteConfig({required List<AppPath> routeConfig}) {
    state = state.copyWith(routeConfig: routeConfig);
  }

  void pushRoute({required AppPath appPath}) {
    state = state.copyWith(routeConfig: state.routeConfig..add(appPath));
  }

  void popRoute() {
    state = state.copyWith(routeConfig: state.routeConfig..removeLast());
  }
}

final navigationProvider =
    StateNotifierProvider<AppRouteConfigStateNotifier, AppRouteConfig>((ref) =>
        AppRouteConfigStateNotifier(
            state: AppRouteConfig(routeConfig: [HomePath()])));

typedef NavigationProvider
    = StateNotifierProvider<AppRouteConfigStateNotifier, AppRouteConfig>;
