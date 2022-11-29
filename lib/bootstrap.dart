import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError =
      (details) => log(details.exceptionAsString(), stackTrace: details.stack);

  runApp(await builder());
}
