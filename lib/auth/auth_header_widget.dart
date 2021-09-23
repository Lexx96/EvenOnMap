import 'package:flutter/material.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 10 * 0.1,
          ),
          Text(
            'EventOnMap',
            style: TextStyle(fontSize: 45, color: Colors.green),
          ),
        ],
      ),
    );
  }
}