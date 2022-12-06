import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

class BattleBotsBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('$bloc $change');
    super.onChange(bloc, change);
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   log('$bloc $transition');
  //   super.onTransition(bloc, transition);
  // }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError =
      (details) => log(details.exceptionAsString(), stackTrace: details.stack);
  WidgetsFlutterBinding.ensureInitialized();

  switch (Platform.operatingSystem) {
    case 'android':
    case 'ios':
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      await Flame.device.fullScreen();
      break;
    case 'windows':
      await windowManager.ensureInitialized();
      WindowOptions windowOptions = const WindowOptions(
        size: Size(800, 600),
        minimumSize: Size(800, 600),
        maximumSize: Size(800, 600),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
      );
      await windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
      break;
    case 'macos':
      break;
  }

  runApp(await builder());
}
