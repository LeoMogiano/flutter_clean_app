// lib/core/widgets/connectivity_guard.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/bootstrap/injection.dart';
import 'package:my_app/core/services/connectivity/connectivity_service.dart';

class ConnectivityGuard extends StatefulWidget {
  const ConnectivityGuard({
    required this.child,
    this.offlineWidget,
    super.key,
  });

  final Widget child;
  final Widget? offlineWidget;

  @override
  State<ConnectivityGuard> createState() => _ConnectivityGuardState();
}

class _ConnectivityGuardState extends State<ConnectivityGuard> {
  final ConnectivityService _connectivity = sl<ConnectivityService>();
  StreamSubscription<bool>? _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    unawaited(_checkInitialConnection());
    _subscription = _connectivity.onStatusChange.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    final isConnected = await _connectivity.isConnected;
    if (!mounted) return;
    setState(() => _isConnected = isConnected);
  }

  void _updateConnectionStatus(bool isConnected) {
    if (!mounted) return;
    setState(() => _isConnected = isConnected);
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected) return widget.child;
    return widget.offlineWidget ?? _defaultOfflineWidget();
  }

  Widget _defaultOfflineWidget() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Sin conexión a internet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Verifica tu conexión e intenta nuevamente',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
