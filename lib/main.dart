import 'package:flutter/material.dart' hide SliverAppBar, FlexibleSpaceBar;
import 'package:tg_appbar/flexible_space_bar.dart';
import 'package:tg_appbar/list_wheel.dart';
import 'package:tg_appbar/custom_sliver_appbar.dart';
import 'package:tg_appbar/sliver_persistent_header.dart';
import 'package:tg_appbar/tg_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          TgAppBar(
            stretch: true,
            titleSpacing: 30,
            stretchTriggerOffset: 100,
            title: Text('Title'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => ListWheel())));
                  },
                  icon: Icon(Icons.dangerous))
            ],
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: kToolbarHeight * 2.5,
            flexibleSpace: FlexibleSpaceBar.createSettings(
              currentExtent: kToolbarHeight,
              // maxExtent: kToolbarHeight + 30,
              // minExtent: kToolbarHeight - 30,
              child: const FlexibleSpaceBar(
                title: Text('SliverAppBar'),
                background: FlutterLogo(),
              ),
            ),
          ),
          // SliverAppBar(
          // stretch: true,
          // titleSpacing: 30,
          // stretchTriggerOffset: 100,
          // title: Text('Title'),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: ((context) => ListWheel())));
          //       },
          //       icon: Icon(Icons.dangerous))
          // ],
          // pinned: _pinned,
          // snap: _snap,
          // floating: _floating,
          // expandedHeight: kToolbarHeight * 2.5,
          // flexibleSpace: FlexibleSpaceBar.createSettings(
          //   currentExtent: kToolbarHeight,
          //   child: const FlexibleSpaceBar(
          //     title: Text('SliverAppBar'),
          //     background: FlutterLogo(),
          //   ),
          // ),
          // ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('pinned'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _pinned = val;
                      });
                    },
                    value: _pinned,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;
                        // Snapping only applies when the app bar is floating.
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('floating'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
