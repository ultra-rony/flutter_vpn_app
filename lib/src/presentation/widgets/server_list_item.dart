import 'package:flutter/material.dart';
import 'package:vpnapp/core/models/v2ray_server.dart';

class ServerListItem extends StatelessWidget {
  final V2RayServer server;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onShare;
  final bool censorAddress;

  const ServerListItem({
    super.key,
    required this.server,
    required this.isSelected,
    required this.onTap,
    this.onShare,
    this.censorAddress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      server.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      censorAddress
                          ? '${server.protocol.toUpperCase()} • ${_censorString(server.address)}'
                          : '${server.protocol.toUpperCase()} • ${server.address}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _censorString(String input) {
    if (input.length <= 8) return input;
    return '${input.substring(0, 4)}***${input.substring(input.length - 4)}';
  }
}
