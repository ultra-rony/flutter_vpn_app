import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpnapp/core/models/v2ray_server.dart';
import 'package:vpnapp/src/presentation/cubit/home_cubit.dart';

@RoutePage()
class ServerListPage extends StatelessWidget {
  const ServerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Выберите локацию'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => context.router.back(),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.servers.isEmpty) {
            return const Center(
              child: Text(
                'Список серверов пуст',
                style: TextStyle(color: Colors.white54),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.servers.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final server = state.servers[index];
              final isSelected = state.selectedServer?.id == server.id;

              return _ServerTile(
                server: server,
                isSelected: isSelected,
                onTap: () {
                  context.read<HomeCubit>().selectServer(server);
                  context.router.back();
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _ServerTile extends StatelessWidget {
  final V2RayServer server;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServerTile({
    required this.server,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blueAccent.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.blueAccent : Colors.white10,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.public, color: Colors.white70),
        ),
        title: Text(
          server.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${server.protocol.toUpperCase()} • ${server.address}',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 12,
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.blueAccent)
            : const Icon(Icons.radio_button_off, color: Colors.white24),
      ),
    );
  }
}
