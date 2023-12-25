import 'package:app_navigation_recalling/navigation/app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/app_route_config.dart';

class HomePage extends ConsumerWidget {
  final NavigationProvider _navigationProvider;

  HomePage() : _navigationProvider = navigationProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home page'),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(_navigationProvider.notifier).popRoute();
              },
              icon: Icon(Icons.arrow_back)),
          IconButton(
              onPressed: () {
                ref
                    .read(_navigationProvider.notifier)
                    .pushRoute(appPath: LaunchPath());
              },
              icon: Icon(Icons.arrow_forward))
        ],
      ),
    );
  }
}
