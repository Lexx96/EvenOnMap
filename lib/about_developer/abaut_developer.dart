import 'package:flutter/material.dart';

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Event On Map', style: TextStyle(fontSize: 22.0),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Версия 1.0.0 + 1', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
                  ),
                  Image(
                    image: AssetImage('assets/images/image_developer.png'),
                  ),
                  Text('© 2021 Event On Map inc', style: TextStyle(fontSize: 14.0, color: Colors.grey),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
