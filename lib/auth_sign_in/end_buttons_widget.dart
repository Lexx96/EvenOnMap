
import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

import 'bloc/user_registration_bloc.dart';

class EndButtonsWidget extends StatelessWidget {
  const EndButtonsWidget({
    Key? key,
    required double height,
    required ServiceSignInBloc bloc,
  }) : _height = height, _bloc = bloc, super(key: key);

  final double _height;
  final ServiceSignInBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(S.of(context).license),
          SizedBox(height: _height * 1),
          TextButton(
            style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all(Colors.white),
                backgroundColor:
                MaterialStateProperty.all(Colors.blue),
                overlayColor: MaterialStateProperty.all(
                    Colors.amberAccent),
                shadowColor:
                MaterialStateProperty.all(Colors.grey),
                elevation: MaterialStateProperty.all(5),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ))),
            onPressed: () {
              _bloc.loadingBloc('79134322031', '12345');
              Navigator.of(context)
                .pushNamed(
                MainNavigationRouteName.mainScreen);},
            child: Text(
              S.of(context).registration,
              style: TextStyle(fontSize: 23),
            ),
          ),
          SizedBox(height: _height * 0.1),
          TextButton(
            style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all(Colors.white),
                backgroundColor:
                MaterialStateProperty.all(Colors.blue),
                overlayColor: MaterialStateProperty.all(
                    Colors.amberAccent),
                shadowColor:
                MaterialStateProperty.all(Colors.grey),
                elevation: MaterialStateProperty.all(5),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ))),
            onPressed: () {},
            child: Text(
              S.of(context).sendVerificationCode,
              style: TextStyle(fontSize: 23),
            ),
          ),
        ],
      ),
    );
  }
}


