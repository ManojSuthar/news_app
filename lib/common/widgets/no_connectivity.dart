import 'package:flutter/material.dart';
import 'package:newsapi_sample/main.dart';
import 'package:provider/provider.dart';

import '../../providers/connectivity_provider.dart';

class NoConnectivity extends StatelessWidget {
  const NoConnectivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivity, child) {
        if (connectivity.isOnline) {
          Future.microtask(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          });
        }

        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.signal_wifi_off_rounded, size: 80),
                Text(
                  "Oops!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                Text(
                  "There is no internet connection.\nPlease check your connection.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
