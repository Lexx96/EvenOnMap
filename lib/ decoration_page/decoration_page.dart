

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class DecorationPage extends StatelessWidget {
  const DecorationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Text('Тут будет что то по оформлению'),
                  TextButton(onPressed: () => AdaptiveTheme.of(context).toggleThemeMode(), child: Text('Сменить тему'))

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
