import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<AppBootstrapMarker>()) {
    return;
  }

  getIt.registerSingleton(const AppBootstrapMarker());
}

class AppBootstrapMarker {
  const AppBootstrapMarker();
}
