

import 'package:event_on_map/generated/l10n.dart';
import 'package:flutter/material.dart';

class FormAuthWidget extends StatefulWidget {
  const FormAuthWidget({Key? key}) : super(key: key);

  @override
  State<FormAuthWidget> createState() => _FormAuthWidgetState();
}

class _FormAuthWidgetState extends State<FormAuthWidget> {

  final _numberController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _textStyle = TextStyle(fontSize: 16, color: Colors.white);

  void numberText(){
    final _numberText = _numberController.text;

  }

  @override
  void initState() {
    super.initState();
    _numberController.addListener(numberText);
    _passwordTextController.addListener(numberText);
  }


  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: _height * 0.01, bottom: _height * 0.07),
          child: Text(S.of(context).enterYourPhoneNumber, style: _textStyle),
        ),
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
            hintText: S.of(context).phoneNumber,
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
          controller: _numberController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: _height * 0.02),
        Text(S.of(context).enterThePassword, style: _textStyle),
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
            hintText: '     ' + S.of(context).password,
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
          controller: _passwordTextController,
        ),
      ],
    );
  }
}