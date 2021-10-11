import 'package:event_on_map/generated/l10n.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _numberTextFieldController = TextEditingController();
    final _passwordTextFieldController = TextEditingController();
    final _height = MediaQuery.of(context).size.height / 10;
    final _textStyle = TextStyle(fontSize: 16, color: Colors.white);
    return Column(
      children: [
        SizedBox(height: _height * 0.1),
        Text(S.of(context).enterYourPhoneNumber, style: _textStyle),
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
            hintText: S.of(context).phoneNumber,
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
        Text(S.of(context).enterThePassword, style: _textStyle),
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
            hintText: '     ' + S.of(context).password,
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
        Text(S.of(context).confirmationCode, style: _textStyle),
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
            hintText: '     ' + S.of(context).code,
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
      ],
    );
  }
}