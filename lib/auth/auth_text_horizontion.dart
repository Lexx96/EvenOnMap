import 'package:flutter/material.dart';

class AuthTextAuthorization extends StatelessWidget {
  const AuthTextAuthorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Войдите в свой аккаунт или',
            style: TextStyle(fontSize: 13, color: Colors.grey)),
        TextButton(
            onPressed: () => Navigator.of(context).pushNamed('auth/authSignIn'),
            child: Text('зарегистритуйтесь',
                style: TextStyle(fontSize: 13, color: Colors.blue))),
      ],
    );
  }
}