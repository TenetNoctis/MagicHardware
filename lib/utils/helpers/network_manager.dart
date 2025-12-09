import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../popups/loaders.dart';

/// A class that manages the network connectivity status of the application.
///
/// This class uses the `connectivity_plus` package to monitor the network state
/// and provides a reactive interface to the rest of the application. It also
/// displays a toast message when the device loses internet connection.
class NetworkManager extends GetxController {
  /// Provides a singleton instance of the [NetworkManager].
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus = <ConnectivityResult>[].obs;
  final RxBool isConnectedStatus = true.obs;

  /// Initializes the network manager.
  ///
  /// This method sets up the initial connectivity status and subscribes to
  /// connectivity changes.
  @override
  void onInit() {
    super.onInit();
    _initializeConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  /// Initializes the connectivity status when the manager is first created.
  Future<void> _initializeConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      _connectionStatus.value = [ConnectivityResult.none];
      isConnectedStatus.value = false;
    }
  }

  /// Updates the connection status based on the connectivity result.
  ///
  /// This method updates the reactive variables and shows a toast message
  /// if the connection is lost.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;

    final hasConnection = !result.contains(ConnectivityResult.none);
    isConnectedStatus.value = hasConnection;

    if (!hasConnection) {
      MagicLoaders.customToast(message: 'No Internet Connection');
    }
  }

  /// Checks the current internet connectivity status.
  ///
  /// Returns `true` if the device is connected to the internet, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return !result.any((element) => element == ConnectivityResult.none);
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Cancels the connectivity subscription when the controller is closed.
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
