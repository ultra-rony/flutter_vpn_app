part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<V2RayServer> servers,
    V2RayServer? selectedServer,
    @Default(VPNConnectionStatus.disconnected) VPNConnectionStatus connectionStatus,
    @Default(false) bool isLoading,
    IpinfoEntity? ipInfo,
  }) = _HomeState;
}
