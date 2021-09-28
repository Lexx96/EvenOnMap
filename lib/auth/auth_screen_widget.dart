import 'package:event_on_map/auth/auth_header_widget.dart';
import 'package:event_on_map/auth/auth_main_image.dart';
import 'package:event_on_map/auth/auth_screen_model.dart';
import 'package:event_on_map/auth/auth_text_horizontion.dart';
import 'package:event_on_map/auth_sign_in/main_screen_decoration.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _model = AuthModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthScreenWidgetProvider(
        model: _model,
        child: MainScreenDecoration(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const AuthHeaderWidget(),
                SizedBox(height: 20,),
                const AuthMainImage(),
                const _FormWidget(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                const AuthTextAuthorization(),
                TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      overlayColor: MaterialStateProperty.all(Colors.grey),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      elevation: MaterialStateProperty.all(5),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ))),
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(MainNavigationRouteName.mainScreen),
                  child: Text(
                    'Войти',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.blue),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor: MaterialStateProperty.all(Colors.grey),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      elevation: MaterialStateProperty.all(5),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ))),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(MainNavigationRouteName.authSignUp),
                  child: const Expanded(
                    child: const Text(
                      'Регистрация',
                      style: const TextStyle(fontSize: 23),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _numberTextFieldController = TextEditingController();
    final _passwordTextFieldController = TextEditingController();
    final _height = MediaQuery.of(context).size.height;
    final _textStyle = TextStyle(fontSize: 16, color: Colors.white);
    return Column(
      children: [
        SizedBox(height: _height * 0.01),
        Text('Введите номер телефона', style: _textStyle),
        SizedBox(height: _height * 0.01),
        TextField(
          decoration: InputDecoration(
            prefix: const Text('+7'),
            prefixStyle: const TextStyle(color: Colors.black, fontSize: 16),
            prefixIcon: const Icon(
              Icons.phone,
              color: Colors.green,
            ),
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Номер телефона',
            hintStyle: const TextStyle(color: Colors.green),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.0, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.green,
              ),
            ),
          ),
          //controller: _numberTextFieldController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: _height * 0.02),
        Text('Введите пароль', style: _textStyle),
        SizedBox(height: _height * 0.01),
        TextField(
          decoration: InputDecoration(
            prefixStyle: const TextStyle(color: Colors.black, fontSize: 16),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.green,
            ),
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Пароль',
            hintStyle: const TextStyle(color: Colors.green),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1.0, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.green,
              ),
            ),
          ),
          obscureText: true,
          // скрывать вводимые данные, как правело для паролей
          obscuringCharacter: '*',
          controller: _passwordTextFieldController,
        ),
      ],
    );
  }
}
