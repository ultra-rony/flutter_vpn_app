import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:vpnapp/core/di/injectable.config.dart';
import 'package:vpnapp/core/utils/v2ray_service.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  getIt.init();
  V2RayService v2rayService = V2RayService();
  getIt.registerSingleton<V2RayService>(v2rayService);
}
