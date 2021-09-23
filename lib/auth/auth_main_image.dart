import 'package:flutter/material.dart';

class AuthMainImage extends StatelessWidget {
  const AuthMainImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10 * 4,
      width: MediaQuery.of(context).size.width / 10 * 9,
      child: Image(image: AssetImage('assets/images/mapOne.png')),
    );
  }
}