import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpnapp/app/route/app_routers.dart';
import 'package:vpnapp/app/theme/theme.dart';
import 'package:vpnapp/core/di/injectable.dart';
import 'package:vpnapp/src/presentation/cubit/home_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final appRouter = AppRouters();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: theme,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
