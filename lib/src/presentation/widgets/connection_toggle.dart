import 'package:flutter/material.dart';
import 'package:vpnapp/core/utils/v2ray_service.dart';

class ConnectionToggle extends StatelessWidget {
  final VPNConnectionStatus status;
  final bool isConnecting;
  final bool hasSelectedServer;
  final VoidCallback onToggle;

  const ConnectionToggle({
    super.key,
    required this.status,
    required this.isConnecting,
    required this.hasSelectedServer,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isConnected = status == VPNConnectionStatus.connected;
    final isProcessing =
        isConnecting ||
        status == VPNConnectionStatus.connecting ||
        status == VPNConnectionStatus.disconnecting;

    final isEnabled = (hasSelectedServer || isConnected) && !isProcessing;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: double.infinity, height: 1),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 64,
            child: ElevatedButton(
              onPressed: isEnabled ? onToggle : null,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: isProcessing
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.black,
                      ),
                    )
                  : Text(
                      isConnected
                          ? 'Отключить'
                          : (isConnecting ? 'Подлючение...' : 'Подлючено'),
                      style: const TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
            ),
          ),
          if (!hasSelectedServer && !isConnected) ...[
            const SizedBox(height: 12),
            const Text(
              'ВЫБЕРИТЕ ПУНКТ НАЗНАЧЕНИЯ ДЛЯ НАЧАЛА',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
