import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpnapp/app/app.dart';

import 'package:vpnapp/core/bloc/app_bloc_observer.dart';

import 'core/di/injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  Bloc.observer = getIt<AppBlocObserver>();

  runApp(App());
}