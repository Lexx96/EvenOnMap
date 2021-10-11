//
// import 'package:flutter/material.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'bloc/user_registration_bloc.dart';
//
// class MyCountdownTimerWidget extends StatelessWidget {
//   ServiceSignInBloc bloc;
//
//   MyCountdownTimerWidget({Key? key, required this.bloc}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     int endTime = DateTime.now().millisecondsSinceEpoch+ 1000 * 20;
//     return CountdownTimer(
//         textStyle: TextStyle(color: Colors.red, fontSize: 17),
//         endTime: endTime,
//         onEnd: () => bloc.emptyState(),
//         endWidget:
//             TextButton(onPressed: () {}, child: Text('Отправить повторно')));
//   }
// }
//
//
