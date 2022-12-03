import 'package:batlle_bots/blocs/chat/chat_bloc.dart';
import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../repositories/repositories_barrel.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final RouterRepository routerRepository = RouterRepository();
    final GoRouter router = routerRepository.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (_) => GameBloc()
            ..add(GameSetClient())
            ..add(GameGetPlayerCountEvent()),
          lazy: false,
        ),
        BlocProvider<ChatBloc>(
          create: (_) => ChatBloc()..add(ChatInitializeEvent()),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        theme: ThemeData(
          scaffoldBackgroundColor: primaryColor,
        ),
      ),
    );
  }
}
