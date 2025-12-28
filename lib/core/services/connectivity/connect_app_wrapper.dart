import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/bootstrap/injection.dart';
import 'package:my_app/core/services/connectivity/connectivity_service.dart';

class ConnectivityWrapper extends StatefulWidget {
  const ConnectivityWrapper({
    required this.child,
    this.showBanner = true,
    super.key,
  });

  final Widget child;
  final bool showBanner;

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  final ConnectivityService _connectivity = sl<ConnectivityService>();
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    unawaited(_checkInitialConnection());
  }

  Future<void> _checkInitialConnection() async {
    final isConnected = await _connectivity.isConnected;
    if (!mounted) return;
    setState(() => _isConnected = isConnected);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _connectivity.onStatusChange,
      initialData: _isConnected,
      builder: (context, snapshot) {
        final isConnected = snapshot.data ?? true;

        return Column(
          children: [
            if (widget.showBanner && !isConnected)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: Colors.red,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Sin conexión a internet',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

            Expanded(child: widget.child),
          ],
        );
      },
    );
  }
}
