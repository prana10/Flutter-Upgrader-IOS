import 'package:firebase_remote_config/firebase_remote_config.dart';
import '/path.dart';

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig _firebaseRemoteConfig;

  FirebaseRemoteConfigService(this._firebaseRemoteConfig);

  // set defaults
  Future<void> _setDefaults() async {
    // set default value of remote config
    await _firebaseRemoteConfig.setDefaults(const {
      FirebaseRemoteConfigKey.latestVersion: "1.0.0",
      FirebaseRemoteConfigKey.latestBuildNumber: "1",
    });
  }

  // remote config get latest version & build number
  String get latestVersion => _firebaseRemoteConfig.getString(
        FirebaseRemoteConfigKey.latestVersion,
      );
  int get buildNumber => _firebaseRemoteConfig.getInt(
        FirebaseRemoteConfigKey.latestBuildNumber,
      );

  // set config settings
  Future<void> _setRemoteConfigSettings() async {
    // remote config set config settings
    // config settings digunakan untuk mengatur fetch timeout dan minimum fetch interval
    await _firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
  }

  // fetch and activate remote config
  Future<void> fetchAndActivate() async {
    // fetch and activate remote config
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  // initialize
  Future<void> initialize() async {
    await _setDefaults();
    await _setRemoteConfigSettings();
    await fetchAndActivate();
  }
}
