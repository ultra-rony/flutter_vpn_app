import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vpnapp/core/models/v2ray_server.dart';
import 'package:vpnapp/core/network/network_result.dart';
import 'package:vpnapp/core/utils/v2ray_service.dart';
import 'package:vpnapp/src/data/mappers/ipinfo_mapper.dart';
import 'package:vpnapp/src/data/models/ipinfo_model.dart';
import 'package:vpnapp/src/domain/entities/ipinfo_entity.dart';
import 'package:vpnapp/src/domain/use_cases/get_remote_ipinfo_use_case.dart';
import 'package:vpnapp/src/domain/use_cases/get_remote_remnawave_vless_use_case.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

@LazySingleton()
class HomeCubit extends HydratedCubit<HomeState> {
  final V2RayService _service;
  final GetRemoteIpinfoUseCase _getRemoteIpinfoUseCase;
  final GetRemoteRemnawaveVlessUseCase _getRemoteRemnawaveVlessUseCase;
  StreamSubscription? _statusSub;

  HomeCubit(
    this._service,
    this._getRemoteIpinfoUseCase,
    this._getRemoteRemnawaveVlessUseCase,
  ) : super(const HomeState()) {
    _init();
  }

  void _init() async {
    await _service.init();

    // Синхронизируем state с реальным состоянием сервиса
    final realStatus = _service.status;
    emit(state.copyWith(connectionStatus: realStatus));

    // Если уже подключены — сразу запрашиваем IP инфо
    if (realStatus == VPNConnectionStatus.connected) {
      _fetchIpInfo();
    }

    // Подписываемся на изменения статуса подключения
    _statusSub = _service.statusStream.listen((status) {
      emit(state.copyWith(connectionStatus: status));

      // ДОБАВИТЬ ЭТО:
      if (status == VPNConnectionStatus.connected) {
        _fetchIpInfo();
      } else if (status == VPNConnectionStatus.disconnected) {
        // Опционально: очищаем инфо при отключении
        emit(state.copyWith(ipInfo: null));
      }
    });

    if (state.servers.isEmpty) {
      // первый запуск
      emit(state.copyWith(servers: []));
    }
  }

  void add(String link) async {
    try {
      // Пытаемся распарсить как одиночную V2Ray ссылку (vmess/vless)
      final newServer = V2RayServer.fromAnyLink(link);
      final updatedServers = [...state.servers, newServer];
      emit(
        state.copyWith(
          servers: updatedServers,
          selectedServer: state.selectedServer ?? newServer,
        ),
      );
    } catch (e) {
      // Если это не ссылка — возможно это подписка (base64 список) Remnawave
      final resp = await _getRemoteRemnawaveVlessUseCase(params: link);
      if (resp is Success) {
        final List<V2RayServer> parsedServers = [];

        // Пробегаемся по всем строкам из подписки
        for (var item in resp.data ?? []) {
          try {
            final server = V2RayServer.fromAnyLink(item);
            parsedServers.add(server);
          } catch (_) {
            // Игнорируем мусор
          }
        }
        // Если вообще ничего не распарсилось просто выходим
        if (parsedServers.isEmpty) {
          return;
        }

        // Добавляем все новые сервера к текущим
        final updatedServers = [...state.servers, ...parsedServers];
        emit(
          state.copyWith(
            servers: updatedServers,
            selectedServer: state.selectedServer ?? parsedServers.first,
          ),
        );
      }
    }
  }

  Future<void> selectServer(V2RayServer server) async {
    // Если этот сервер уже выбран ничего не делаем
    if (state.selectedServer?.id == server.id) return;

    // Если сейчас есть активное VPN подключение
    if (state.connectionStatus == VPNConnectionStatus.connected) {
      await _service.disconnect();
      emit(state.copyWith(selectedServer: server));
      await _service.connect(server);
      _fetchIpInfo();
    } else {
      // Если VPN не подключен просто меняем выбранный сервер
      emit(state.copyWith(selectedServer: server));
    }
  }

  Future<void> _fetchIpInfo() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      final resp = await _getRemoteIpinfoUseCase();
      emit(state.copyWith(ipInfo: resp.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleConnection() async {
    // Если сервер не выбран ничего не делаем
    if (state.selectedServer == null) return;
    try {
      // Если уже подключены — отключаемся
      if (state.connectionStatus == VPNConnectionStatus.connected) {
        await _service.disconnect();
      } else {
        // Загрузка
        emit(state.copyWith(connectionStatus: VPNConnectionStatus.connecting));
        // Если не подключены подключаемся к выбранному серверу
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
        ipInfo: json['ipInfo'] != null
            ? IpinfoModel.fromJson(
                json['ipInfo'] as Map<String, dynamic>,
              ).toEntity()
            : null,
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
      'ipInfo': state.ipInfo?.toModel().toJson(),
    };
  }

  @override
  Future<void> close() {
    _statusSub?.cancel();
    return super.close();
  }
}
