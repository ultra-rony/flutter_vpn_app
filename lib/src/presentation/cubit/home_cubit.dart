import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vpnapp/core/models/v2ray_server.dart';
import 'package:vpnapp/core/utils/v2ray_service.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

@LazySingleton()
class HomeCubit extends HydratedCubit<HomeState> {
  final V2RayService _service;
  StreamSubscription? _statusSub;

  HomeCubit(this._service) : super(const HomeState()) {
    _init();
  }

  void _init() async {
    await _service.init();

    // Сначала узнаем реальный статус у нативного движка
    final realStatus = _service.status;
    emit(state.copyWith(connectionStatus: realStatus));

    // Затем подписываемся на стрим изменений
    _statusSub = _service.statusStream.listen((status) {
      emit(state.copyWith(connectionStatus: status));
    });

    if (state.servers.isEmpty) {
      _loadServers();
    }
  }

  void _loadServers() {
    final rawLinks = [];

    final servers = rawLinks
        .map((link) => V2RayServer.fromAnyLink(link))
        .toList();
    emit(state.copyWith(servers: servers));
  }

  void add(String link) {
    try {
      final newServer = V2RayServer.fromAnyLink(link);
      final updatedServers = [...state.servers, newServer];
      emit(
        state.copyWith(
          servers: updatedServers,
          selectedServer: state.selectedServer ?? newServer,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> selectServer(V2RayServer server) async {
    if (state.selectedServer?.id == server.id) return;

    if (state.connectionStatus == VPNConnectionStatus.connected) {
      await _service.disconnect();
      emit(state.copyWith(selectedServer: server));
      await _service.connect(server);
    } else {
      emit(state.copyWith(selectedServer: server));
    }
  }

  Future<void> toggleConnection() async {
    if (state.selectedServer == null) return;

    try {
      if (state.connectionStatus == VPNConnectionStatus.connected) {
        await _service.disconnect();
      } else {
        await _service.connect(state.selectedServer!);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      return HomeState(
        servers:
            (json['servers'] as List<dynamic>?)
                ?.map((e) => V2RayServer.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        selectedServer: json['selectedServer'] != null
            ? V2RayServer.fromJson(
                json['selectedServer'] as Map<String, dynamic>,
              )
            : null,
      );
    } catch (_) {
      return const HomeState();
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return {
      'servers': state.servers.map((e) => e.toJson()).toList(),
      'selectedServer': state.selectedServer?.toJson(),
    };
  }

  @override
  Future<void> close() {
    _statusSub?.cancel();
    return super.close();
  }
}
