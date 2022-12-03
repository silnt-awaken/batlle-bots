import 'package:batlle_bots/app/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class StartMenuView extends StatelessWidget {
  const StartMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ['Lobby', 'Garage', 'Settings']
                    .map(
                      (String text) => MenuButton(
                        text: text,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
