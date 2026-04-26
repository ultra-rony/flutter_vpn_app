import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpnapp/core/di/injectable.dart';
import 'package:vpnapp/core/utils/v2ray_service.dart';
import 'package:vpnapp/src/presentation/cubit/home_cubit.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text('VPN PRO', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w900)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 24),
              _buildStatusIndicator(state.connectionStatus),
              const Expanded(child: _ServerListSection()),
            ],
          );
        },
      ),
      bottomNavigationBar: const _BottomControlPanel(),
    );
  }

  Widget _buildStatusIndicator(VPNConnectionStatus status) {
    final isConnected = status == VPNConnectionStatus.connected;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isConnected ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isConnected ? Icons.shield : Icons.shield_outlined,
            size: 64,
            color: isConnected ? Colors.green : Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          status.name.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isConnected ? Colors.green : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class _ServerListSection extends StatelessWidget {
  const _ServerListSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.servers.isEmpty) return const Center(child: Text("Загрузка серверов..."));

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: state.servers.length,
          itemBuilder: (context, index) {
            final server = state.servers[index];
            final isSelected = state.selectedServer?.id == server.id;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ServerListItem(
                server: server,
                isSelected: isSelected,
                onTap: () => context.read<HomeCubit>().selectServer(server),
              ),
            );
          },
        );
      },
    );
  }
}

class _BottomControlPanel extends StatelessWidget {
  const _BottomControlPanel();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeCubit>().state;
    final isConnected = state.connectionStatus == VPNConnectionStatus.connected;
    final isConnecting = state.connectionStatus == VPNConnectionStatus.connecting;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: state.selectedServer == null || isConnecting
              ? null
              : () => context.read<HomeCubit>().toggleConnection(),
          style: ElevatedButton.styleFrom(
            backgroundColor: isConnected ? Colors.redAccent : Colors.blueAccent,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: isConnecting
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(isConnected ? 'ОТКЛЮЧИТЬ' : 'ПОДКЛЮЧИТЬ'),
        ),
      ),
    );
  }
}
