import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isOnline = true;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  ConnectivityProvider() {
    // _checkConnectivity();
    Future.delayed(Duration.zero, _checkConnectivity);
  }

  bool get isOnline => _isOnline;

  void _checkConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _updateStatus(result);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateStatus,
    );
  }

  void _updateStatus(ConnectivityResult result) {
    bool newStatus = result != ConnectivityResult.none;
    if (_isOnline != newStatus) {
      _isOnline = newStatus;
      notifyListeners(); // Notify UI to rebuild
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
