import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vpnapp/app/app.dart';

import 'package:vpnapp/core/bloc/app_bloc_observer.dart';

import 'core/di/injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  Bloc.observer = getIt<AppBlocObserver>();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
    kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(App());
}