import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError =
      (details) => log(details.exceptionAsString(), stackTrace: details.stack);
  WidgetsFlutterBinding.ensureInitialized();
  // set the landscape orientation for android devices
  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  runApp(await builder());
}
