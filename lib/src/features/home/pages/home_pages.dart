import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/path.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.versionUpgrader,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final VersionUpgrader versionUpgrader;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AfterLayoutMixin<MyHomePage> {
  int _counter = 0;

  late PackageInfo _packageInfo;
  final Uri _appstoreLink = Uri.parse(
    'https://apps.apple.com/id/app/youtube/id544007664?l=id',
  );

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    if (Platform.isIOS) {
      var injectionHomeFirebase = getIt<FirebaseRemoteConfigService>();
      // jika version dari package info lebih kecil dari version yang ada di firestore
      // maka tampilkan bottom sheet
      _initPackageInfo().then((_) {
        // set build number from remote config
        var versionUpgrader = widget.versionUpgrader;
        versionUpgrader.buildNumber = injectionHomeFirebase.buildNumber;
        versionUpgrader.version = injectionHomeFirebase.latestVersion;

        debugPrint('build number: ${versionUpgrader.buildNumber}');
        debugPrint('version: ${versionUpgrader.version}');

        // jika build number dari package info lebih kecil dari build number yang ada di firestore
        if (int.parse(_packageInfo.buildNumber) <
            widget.versionUpgrader.buildNumber) {
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            useSafeArea: true,
            enableDrag: false,
            builder: (context) {
              return MyBottomSheet(
                appstoreLink: _appstoreLink,
                packageInfo: _packageInfo,
                versionUpgrader: widget.versionUpgrader,
              );
            },
          );
        }
      });
    }
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _packageInfo = info;
      });
    }
  }
}
