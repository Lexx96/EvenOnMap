import 'package:event_on_map/auth_sign_in/header_widget.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/auth_sign_in/main_screen_decoration.dart';
import 'package:flutter/material.dart';

class AuthSignUpWidget extends StatelessWidget {
  const AuthSignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height / 10;
    return Scaffold(
      body: MainScreenDecoration(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              HeaderWidget(),
              _FormWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text('Нажимая на кнопку "Регистрация", я подтверждаю, '
                        'что ознакомился(лась) с политикой обработки персональных данных.'),
                  ],
                ),
              ),
              SizedBox(height: _height * 1),
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    overlayColor: MaterialStateProperty.all(Colors.amberAccent),
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    elevation: MaterialStateProperty.all(5),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ))),
                onPressed: () => Navigator.of(context)
                    .pushNamed(MainNavigationRouteName.mainScreen),
                child: Text(
                  'Регистрация',
                  style: TextStyle(fontSize: 23),
                ),
              ),
              SizedBox(height: _height * 0.1),
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    overlayColor: MaterialStateProperty.all(Colors.amberAccent),
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    elevation: MaterialStateProperty.all(5),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ))),
                onPressed: () => Navigator.of(context)
                    .pushNamed(MainNavigationRouteName.auth),
                child: Text(
                  'Отправить проверочный код',
                  style: TextStyle(fontSize: 23),
                ),
              ),
            ],
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
    final _codedTextFieldController = TextEditingController();
    final _height = MediaQuery.of(context).size.height / 10;
    final _textStyle = TextStyle(fontSize: 16, color: Colors.white);
    return Column(
      children: [
        SizedBox(height: _height * 0.1),
        Text('Введите номер телефона', style: _textStyle),
        SizedBox(height: _height * 0.1),
        TextField(
          decoration: InputDecoration(
            prefix: Text('+7'),
            prefixStyle: TextStyle(color: Colors.black, fontSize: 16),
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.green,
            ),
            isCollapsed: true,
            contentPadding: EdgeInsets.all(15),
            hintText: 'Номер телефона',
            hintStyle: TextStyle(color: Colors.green),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1.0, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.green,
              ),
            ),
          ),
          controller: _numberTextFieldController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: _height * 0.2),
        Text('Код подтверждения', style: _textStyle),
        SizedBox(height: _height * 0.1),
        TextField(
          //enabled: false, активно ли поле ввода
          decoration: InputDecoration(
            prefixStyle: TextStyle(color: Colors.black, fontSize: 16),
            prefixIcon: Icon(
              Icons.mail,
              color: Colors.green,
            ),
            isCollapsed: true,
            contentPadding: EdgeInsets.all(15),
            hintText: 'Код',
            hintStyle: TextStyle(color: Colors.green),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1.0, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.green,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: _height * 0.2),
        Text('Введите пароль', style: _textStyle),
        SizedBox(height: _height * 0.1),
        TextField(
          decoration: InputDecoration(
            prefixStyle: TextStyle(color: Colors.black, fontSize: 16),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.green,
            ),
            isCollapsed: true,
            contentPadding: EdgeInsets.all(15),
            hintText: 'Пароль',
            hintStyle: TextStyle(color: Colors.green),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1.0, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
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
        SizedBox(height: _height * 0.2),
      ],
    );
  }
}
