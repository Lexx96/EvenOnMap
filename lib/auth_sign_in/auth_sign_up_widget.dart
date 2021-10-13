// import 'package:event_on_map/auth_sign_in/header_widget.dart';
// import 'package:event_on_map/auth/services/user_registration/user_registration_repository.dart';
// import 'package:event_on_map/navigation/main_navigation.dart';
// import 'package:event_on_map/auth_sign_in/main_screen_decoration.dart';
// import 'package:flutter/material.dart';
// import 'bloc/user_registration_bloc.dart';
// import 'bloc/user_registration_state.dart';
// import 'end_buttons_widget.dart';
// import 'form_widget.dart';
//
// class AuthSignUpWidget extends StatefulWidget {
//   const AuthSignUpWidget({Key? key}) : super(key: key);
//
//   @override
//   _AuthSignUpWidgetState createState() =>
//       _AuthSignUpWidgetState(UserRegistrationRepository());
// }
//
// class _AuthSignUpWidgetState extends State<AuthSignUpWidget> {
//   _AuthSignUpWidgetState(this._repository);
//
//   late ServiceSignInBloc _bloc;
//   late UserRegistrationRepository _repository;
//
//   @override
//   void initState() {
//     super.initState();
//     _bloc = ServiceSignInBloc(_repository);
//     _bloc.emptyState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _height = MediaQuery.of(context).size.height / 10;
//     return Scaffold(
//       body: MainScreenDecoration(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: ListView(
//             children: [
//               StreamBuilder(
//                 stream: _bloc.streamAuthGetter,
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   print(snapshot.data);
//                   if (snapshot.data is ClearBlocEmpty) {
//                     return Column(
//                       children: [
//                         HeaderWidget(),
//                         FormWidget(),
//                         EndButtonsWidget(height: _height, bloc: _bloc),
//                       ],
//                     );
//                   }
//                   if (snapshot.data is ClearBlocLoading) {
//                     return Column(
//                       children: [
//                         HeaderWidget(),
//                         FormWidget(),
//                         EndButtonsWidget(height: _height, bloc: _bloc),
//                       ],
//                     );
//                   }
//                   if (snapshot.data is ClearBlocResponse) {
//                     Navigator.of(context)
//                         .pushNamed(MainNavigationRouteName.userProfile);
//                   }
//                   if (snapshot.data is ClearBlocError) {
//                     return Stack(
//                       children: [
//                         Column(
//                           children: [
//                             HeaderWidget(),
//                             FormWidget(),
//                             EndButtonsWidget(height: _height, bloc: _bloc),
//                           ],
//                         ),
//                         Center(child: Text('Ошибка'))
//                       ],
//                     );
//                   }
//                   return Center(child: Text('Неизвестная ошибка'));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   buildShowDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         });
//   }
//
//   @override
//   void dispose() {
//     _bloc.dispose();
//     super.dispose();
//   }
// }
