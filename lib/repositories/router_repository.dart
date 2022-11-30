import 'package:batlle_bots/app/views/game_view.dart';
import 'package:batlle_bots/app/views/garage_view.dart';
import 'package:batlle_bots/app/views/lobby_view.dart';
import 'package:batlle_bots/app/views/settings_view.dart';
import 'package:batlle_bots/repositories/game_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/views/view.dart';

class RouterRepository {
  late final GoRouter _router;

  GoRouter get router => _router;

  RouterRepository() {
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const StartMenuView();
          },
        ),
        GoRoute(
          path: '/Lobby',
          builder: (BuildContext context, GoRouterState state) {
            return const LobbyView();
          },
        ),
        GoRoute(
          path: '/Garage',
          builder: (BuildContext context, GoRouterState state) {
            return const GarageView();
          },
        ),
        GoRoute(
          path: '/Settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsView();
          },
        ),
        GoRoute(
          path: '/Game',
          builder: (BuildContext context, GoRouterState state) {
            return const GameView();
          },
        ),
      ],
      redirect: (context, state) {
        // so if you're going to /lobby, call this handler
        if (state.location == '/Lobby') {
          GameRepository().init();
          return '/Lobby';
        } else {
          return null;
        }
      },
    );
  }
}
