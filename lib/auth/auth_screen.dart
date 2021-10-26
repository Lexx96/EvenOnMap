import 'package:event_on_map/auth/widgets/auth_header_widget.dart';
import 'package:event_on_map/auth/widgets/auth_text_horizontion_widget.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_api_repository.dart';
import 'package:event_on_map/auth/widgets/form_widget.dart';
import 'package:event_on_map/auth_sign_in/main_screen_decoration.dart';
import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'widgets/auth_main_image_widget.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_bloc_state.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() =>
      _AuthWidgetState(UserRegistrationRepository(), UserLogInRepository());
}

class _AuthWidgetState extends State<AuthWidget> {
  _AuthWidgetState(this._repository, this._authLogInRepository);

  late ServiceAuthBloc _bloc;

  late final UserRegistrationRepository _repository;
  late final UserLogInRepository _authLogInRepository;

  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _textStyle = TextStyle(fontSize: 16, color: Colors.white);

  void _goLogIn(){
    final _numberText = _numberController.text;
    final _passwordText = _passwordController.text;
    print(_numberText + _passwordText);

    if (_numberText.length <= 9 && _passwordText.length <= 7){
      _bloc.errorLengthLoginAndPassword();
    }
    else if (_numberText.length <= 9){
      _bloc.errorLengthNumber();
    }
    else if (_passwordText.length <= 7){
      _bloc.errorLengthPassword();
    }
    else{
      _bloc.loadingLogIn(_numberText, _passwordText);
    }

  }

  void _goRegistration(){
    final _numberText = _numberController.text;
    final _passwordText = _passwordController.text;
    print(_numberText + _passwordText);

    if (_numberText.length <= 9 && _passwordText.length <= 7){
      _bloc.errorLengthLoginAndPassword();
    }
    else if (_numberText.length <= 9){
      _bloc.errorLengthNumber();
    }
    else if (_passwordText.length <= 7){
      _bloc.errorLengthPassword();
    }
    else{
      _bloc.loadingRegistration(_numberText, _passwordText);
    }

  }

  Text showNumberText(AsyncSnapshot snapshot){
    return
      (snapshot.data is ErrorLengthNumber) || (snapshot.data is ErrorLengthLoginAndPassword)
          ? Text('Номер должен содержать 11 знаков', style: TextStyle(color: Colors.red, fontSize:16 ),)
          : Text(S.of(context).enterYourPhoneNumber, style: _textStyle);
  }

  Text showPasswordText (AsyncSnapshot snapshot) {
    return
      (snapshot.data is ErrorLengthPassword) || (snapshot.data is ErrorLengthLoginAndPassword)
          ? Text('Пароль должен содержать 8 знаков и более', style: TextStyle(color: Colors.red, fontSize:16 ),)
          : Text(S.of(context).enterThePassword, style: _textStyle);
  }


  @override
  void initState() {
    super.initState();
    _bloc = ServiceAuthBloc(
      _repository,
      _authLogInRepository,
    );
    _bloc.emptyState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: MainScreenDecoration(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder(
            stream: _bloc.streamController,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data is EmptyBlocState || snapshot.data is AuthRegistrationLoadingState ||
              snapshot.data is AuthLogInLoadingState || snapshot.data is ErrorLengthNumber || snapshot.data is ErrorLengthPassword
                  || snapshot.data is ErrorLengthLoginAndPassword) {
                return Stack(
                  children: [
                    ListView(
                      children: [
                        const AuthHeaderWidget(),
                        const AuthMainImage(),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: _height * 0.01, bottom: _height * 0.01),
                              child: showNumberText(snapshot),
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
                            showPasswordText(snapshot),
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
                              controller: _passwordController,
                            ),
                          ],
                        ),
                        const AuthTextAuthorization(),
                        TextButton(
                          style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                              backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                              overlayColor:
                              MaterialStateProperty.all(Colors.grey),
                              shadowColor:
                              MaterialStateProperty.all(Colors.grey),
                              elevation: MaterialStateProperty.all(5),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                          child: Text(
                            S.of(context).enter,
                            style: TextStyle(fontSize: 23),
                          ),
                          onPressed: () => _goLogIn(),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        TextButton(
                          style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all(Colors.blue),
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              overlayColor:
                              MaterialStateProperty.all(Colors.grey),
                              shadowColor:
                              MaterialStateProperty.all(Colors.grey),
                              elevation: MaterialStateProperty.all(5),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                          onPressed: () => _goRegistration(),
                          child: Expanded(
                            child: Text(
                              S.of(context).registration,
                              style: const TextStyle(fontSize: 23),
                            ),
                          ),
                        ),
                      ],
                    ),
                    (snapshot.data is AuthRegistrationLoadingState || snapshot.data is AuthLogInLoadingState) ? Center(child: CircularProgressIndicator())  : SizedBox.shrink(),
                  ],
                );
              }
              if (snapshot.data is AuthRegistrationLoadedState || snapshot.data is AuthLogInLoadedState) {
                Future.delayed(Duration.zero, () {
                  Navigator.of(context)
                      .pushNamed(MainNavigationRouteName.mainScreen);
                },);
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Неизвестная ошибка'),
                    CircularProgressIndicator()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


