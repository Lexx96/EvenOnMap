import 'package:flutter/material.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16.0, bottom: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 10 * 0.1,
          ),
          const Text(
            'EventOnMap',
            style: TextStyle(fontSize: 45, color: Colors.green),
          ),
        ],
      ),
    );
  }
}