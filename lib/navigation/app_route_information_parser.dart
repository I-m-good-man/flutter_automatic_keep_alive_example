import 'package:app_navigation_recalling/navigation/app_path.dart';
import 'package:app_navigation_recalling/navigation/app_route_config.dart';
import 'package:flutter/material.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRouteConfig> {
  @override
  Future<AppRouteConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    Uri uri = routeInformation.uri;
    List<AppPath> routeConfig = [
      for (String pathSegment in uri.pathSegments)
        switch (pathSegment) {
          'launch-path' => LaunchPath(),
          'home-path' => HomePath(),
          'undefined-path' => UndefinedPath(),
          _ => UndefinedPath()
        }
    ];
    return AppRouteConfig(routeConfig: routeConfig);
  }

  @override
  RouteInformation restoreRouteInformation(AppRouteConfig configuration) {
    Uri uri = Uri(pathSegments: [
      for (AppPath appPath in configuration.routeConfig)
        switch (appPath.runtimeType) {
          LaunchPath => 'launch-path',
          HomePath => 'home-path',
          UndefinedPath => 'undefined-path',
          _ => 'undefined-path'
        }
    ]);
    return RouteInformation(uri: uri);
  }
}
