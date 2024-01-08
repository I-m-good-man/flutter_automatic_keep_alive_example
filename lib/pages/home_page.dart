import 'package:app_navigation_recalling/navigation/app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/app_route_config.dart';

class HomePage extends StatefulWidget {
  final NavigationProvider _navigationProvider;

  HomePage() : _navigationProvider = navigationProvider;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int currentIndex) {
          setState(() {
            this.currentIndex = currentIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: 'Home 1',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'Home 2',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'Home 3',
              icon: Icon(
                Icons.home,
              ))
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home page'),
        actions: [
          IconButton(
              onPressed: () {
                // ref.read(widget._navigationProvider.notifier).popRoute();
              },
              icon: Icon(Icons.arrow_back)),
          IconButton(
              onPressed: () {
                // ref
                //     .read(widget._navigationProvider.notifier)
                //     .pushRoute(appPath: LaunchPath());
              },
              icon: Icon(Icons.arrow_forward))
        ],
      ),
      body: switch (currentIndex) {
        0 => ListViewWidget(2),
        1 => SecondScreen(Colors.yellow),
        2 => SecondScreen(Colors.lightGreenAccent),
        // 2 => SecondScreen(Colors.lightGreenAccent),
        _ => throw Exception('error')
      },
    );
  }
}

class ListViewWidget extends StatefulWidget {
  const ListViewWidget(this.thickness, {super.key});

  final double thickness;

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int itemCount) {
        return Divider(
          thickness: widget.thickness,
        );
      },
      addAutomaticKeepAlives: true,
      itemBuilder: (BuildContext context, int itemCount) {
        return ListViewItem(itemCount);
      },
      itemCount: 50,
    );
  }
}

class ListViewItem extends StatefulWidget {
  final int itemCount;

  const ListViewItem(this.itemCount, {super.key});

  @override
  State<ListViewItem> createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem>
    with AutomaticKeepAliveClientMixin<ListViewItem> {
  bool _keepAlive = true;
  late final Future<int> _future;

  @override
  bool get wantKeepAlive => _keepAlive;

  @override
  void initState() {
    super.initState();
    _future = Future.delayed(Duration(seconds: 5), () => widget.itemCount);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return GestureDetector(
            onDoubleTap: () {
              _keepAlive = false;
              updateKeepAlive();
            },
            child: Container(
              child: Center(
                child: Text(
                  (snapshot.connectionState == ConnectionState.done)
                      ? '${snapshot.data}'
                      : '...',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              color: (widget.itemCount % 2 == 0) ? Colors.red : Colors.green,
              constraints:
                  BoxConstraints(maxWidth: 70, maxHeight: 50, minHeight: 50),
            ),
          );
        });
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen(this.color, {super.key});

  final Color color;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with AutomaticKeepAliveClientMixin<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      separatorBuilder: (BuildContext context, int itemIndex) {
        return Divider();
      },
      itemBuilder: (BuildContext context, int itemIndex) {
        return Container(
          color: widget.color,
          height: 50,
          width: double.infinity,
          child: Text('$itemIndex'),
        );
      },
      itemCount: 50,
    );
  }

  bool _keepAlive = true;

  @override
  bool get wantKeepAlive => _keepAlive;
}
