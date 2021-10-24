import 'package:event_on_map/generated/l10n.dart';
import 'package:flutter/material.dart';

class AuthTextAuthorization extends StatelessWidget {
  const AuthTextAuthorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).logInToYourAccountOr,
            style: const TextStyle(fontSize: 13, color: Colors.grey)),
        TextButton(
            onPressed: () => Navigator.of(context).pushNamed('auth/authSignIn'),
            child: Text(S.of(context).register,
                style: const TextStyle(fontSize: 13, color: Colors.blue))),
      ],
    );
  }
}