import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'bloc/decoration_page_bloc.dart';
import 'bloc/decoration_page_bloc_state.dart';

class DecorationPage extends StatefulWidget {
  const DecorationPage({Key? key}) : super(key: key);

  @override
  State<DecorationPage> createState() => _DecorationPageState();
}

class _DecorationPageState extends State<DecorationPage> {
  late DecorationPageBloc _bloc;



  /// Получение информации о ранее выбранной теме и в зависимости от этого вызов метода bloc
  Future<void> _choiceTheme() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode == AdaptiveThemeMode.system) {
      _bloc.systemThemeState();
    } else if (savedThemeMode == AdaptiveThemeMode.light) {
      _bloc.lightThemeState();
    } else if (savedThemeMode == AdaptiveThemeMode.dark) {
      _bloc.darkThemeState();
    }
  }


  @override
  void initState() {
    super.initState();
    _bloc = DecorationPageBloc();
    _bloc.systemThemeState();
    _choiceTheme();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StreamBuilder(
            stream: _bloc.streamController,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data is SystemThemeDecorationPageState ||
                  snapshot.data is LightThemeDecorationPageState ||
                  snapshot.data is DarkThemeDecorationPageState ||
                  snapshot.data is EmptyDecorationPageState) {
                final _system = snapshot.data is SystemThemeDecorationPageState;
                final _light = snapshot.data is LightThemeDecorationPageState;
                final _dark = snapshot.data is DarkThemeDecorationPageState;
                print(snapshot.data);
                print('11111111111111111111111111111111111111111111111111111');
                return ListView(
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Выбор темы',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20.0),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Системная тема'),
                            Switch(
                              activeColor: Colors.blue,
                              splashRadius: 20,
                              value: (_dark || _light) ? false : true,
                              onChanged: (bool newValue) {
                                _bloc.systemThemeState();
                                AdaptiveTheme.of(context).setSystem();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Светлая тема'),
                            Switch(
                              activeColor: Colors.blue,
                              splashRadius: 20,
                              value: (_dark || _system) ? false : true,
                              onChanged: (bool newValue) {
                                _bloc.lightThemeState();
                                AdaptiveTheme.of(context).setLight();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Темная тема'),
                            Switch(
                              activeColor: Colors.blue,
                              splashRadius: 20,
                              value: (_light || _system) ? false : true,
                              onChanged: (bool newValue) {
                                _bloc.darkThemeState();
                                AdaptiveTheme.of(context).setDark();
                              },
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
