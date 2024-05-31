import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import '/path.dart';

final GetIt getIt = GetIt.instance;
void initInjectionHome() {
  // register firebase remote config service singleton
  getIt.registerSingleton<FirebaseRemoteConfigService>(
    FirebaseRemoteConfigService(
      FirebaseRemoteConfig.instance,
    ),
  );
}
