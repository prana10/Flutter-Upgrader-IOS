import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/path.dart';
import 'package:sample1/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initInjectionApp();
  // set default value of version upgrader
  var versionUpgrader = VersionUpgrader(
    version: '1.0.0',
    buildNumber: 1,
  );
  await getIt.get<FirebaseRemoteConfigService>().initialize();
  runApp(
    MyApp(
      versionUpgrader: versionUpgrader,
    ),
  );
}

class VersionUpgrader {
  String version;
  int buildNumber;

  VersionUpgrader({
    required this.version,
    required this.buildNumber,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.versionUpgrader,
  });

  final VersionUpgrader versionUpgrader;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        versionUpgrader: versionUpgrader,
      ),
    );
  }
}
