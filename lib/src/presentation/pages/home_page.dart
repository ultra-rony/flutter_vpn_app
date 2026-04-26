import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpnapp/core/di/injectable.dart';
import 'package:vpnapp/core/models/v2ray_server.dart';
import 'package:vpnapp/core/utils/v2ray_service.dart';
import 'package:vpnapp/src/presentation/cubit/home_cubit.dart';
import 'package:vpnapp/src/presentation/widgets/connection_toggle.dart';
import 'package:vpnapp/src/presentation/widgets/server_list_item.dart';

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<HomeCubit>(), child: this);
  }
}

class _HomePageState extends State<HomePage> {
  final V2RayService _v2rayService = V2RayService();

  final List<String> _rawServerLinks = [
    "vless://bd700024-ad36-4dec-9289-eb5813a157d9@45.88.15.168:8443?encryption=none&security=tls&type=ws&headerType=none&path=%2Fvless&sni=admin.vipvpnn.ru#VIPVPN%20-%20Netherlands%20%F0%9F%87%B3%F0%9F%87%B1",
    "vless://bd700024-ad36-4dec-9289-eb5813a157d9@45.88.15.168:8443?encryption=none&security=tls&type=ws&headerType=none&path=%2Fvless&sni=admin.vipvpnn.ru#VIPVPN%20-%20Netherlands%20%F0%9F%87%B3%F0%9F%87%B1"
  ];

  List<V2RayServer> _servers = [];
  String? _selectedServerId;
  StreamSubscription<VPNConnectionStatus>? _statusSubscription;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    await _v2rayService.init();

    _statusSubscription = _v2rayService.statusStream.listen((status) {
      if (mounted) {
        setState(() {});
      }
    });

    _loadStaticServers();
  }

  void _loadStaticServers() {
    setState(() {
      _servers = _rawServerLinks.map((link) => V2RayServer.fromAnyLink(link)).toList();
    });
  }

  void _selectServer(String serverId) {
    setState(() {
      _selectedServerId = (_selectedServerId == serverId) ? null : serverId;
    });
  }

  Future<void> _toggleConnection() async {
    if (_v2rayService.status == VPNConnectionStatus.connected) {
      await _v2rayService.disconnect();
    } else {
      if (_selectedServerId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a server first')),
        );
        return;
      }

      final server = _servers.firstWhere((s) => s.id == _selectedServerId);
      await _v2rayService.connect(
        server,
        proxyOnly: false,
        useSystemDns: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('V2RAY CLIENT', style: TextStyle(letterSpacing: 2, fontSize: 14, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildServerList(),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: ConnectionToggle(
          status: _v2rayService.status,
          isConnecting: false,
          hasSelectedServer: _selectedServerId != null,
          onToggle: _toggleConnection,
        ),
      ),
    );
  }

  Widget _buildServerList() {
    if (_servers.isEmpty) {
      return const Center(child: Text("No servers available"));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: _servers.length,
      itemBuilder: (context, index) {
        final server = _servers[index];
        final isSelected = server.id == _selectedServerId;

        return ServerListItem(
          server: server,
          isSelected: isSelected,
          onTap: () => _selectServer(server.id),
          censorAddress: false,
        );
      },
    );
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    _v2rayService.dispose();
    super.dispose();
  }
}
