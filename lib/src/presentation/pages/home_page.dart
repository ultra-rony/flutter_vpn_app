import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpnapp/app/route/app_routers.gr.dart';
import 'package:vpnapp/core/utils/v2ray_service.dart';
import 'package:vpnapp/src/presentation/cubit/home_cubit.dart';
import 'package:vpnapp/src/presentation/widgets/add_server_widget.dart';
import 'package:vpnapp/src/presentation/widgets/server_selection_widget.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeCubit>().state;
    final isConnected = state.connectionStatus == VPNConnectionStatus.connected;
    final isConnecting =
        state.connectionStatus == VPNConnectionStatus.connecting;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => AddServerSheet.show(context),
            icon: const Icon(Icons.add_link, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background_grid.svg',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          if (state.selectedServer != null && !isConnecting) {
                            context.read<HomeCubit>().toggleConnection();
                          } else if (state.selectedServer == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Сначала выберите сервер'),
                              ),
                            );
                          }
                        },
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Center(
                            child: isConnecting
                                ? const CircularProgressIndicator(
                                    strokeWidth: 4,
                                    color: Colors.white,
                                  )
                                : SvgPicture.asset(
                                    !isConnected
                                        ? 'assets/btn_off.svg'
                                        : "assets/btn_on.svg",
                                  ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (state.ipInfo != null && !isConnecting) ...[
                        SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              Text(
                                "${state.ipInfo?.city}, ${state.ipInfo?.country}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "IP: ${state.ipInfo?.ip}",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ] else
                        const SizedBox(height: 120),
                      ServerSelectionWidget(
                        selectedServer: state.selectedServer,
                        onTap: () {
                          context.router.push(const ServerListRoute());
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
