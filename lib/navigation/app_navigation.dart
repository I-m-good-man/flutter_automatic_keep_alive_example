import 'package:app_navigation_recalling/navigation/app_route_information_parser.dart';
import 'package:app_navigation_recalling/navigation/app_router_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AppNavigation {
  static AppRouterDelegate routerDelegate({required WidgetRef ref}) {
    return AppRouterDelegate(ref: ref);
  }

  static AppRouteInformationParser get routeInformationParser =>
      AppRouteInformationParser();
}
