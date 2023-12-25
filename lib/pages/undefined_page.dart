import 'package:app_navigation_recalling/navigation/app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/app_route_config.dart';

class UndefinedPage extends ConsumerWidget {
  final NavigationProvider _navigationProvider;

  UndefinedPage() : _navigationProvider = navigationProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Undefined page'),
      ),
    );
  }
}
