import 'package:event_on_map/auth/auth_header_widget.dart';
import 'package:event_on_map/auth/auth_main_image.dart';
import 'package:event_on_map/auth/auth_text_horizontion.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_repository.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_repository.dart';
import 'package:event_on_map/auth_sign_in/main_screen_decoration.dart';
import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'bloc/auht_bloc_state.dart';
import 'bloc/auth_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    _bloc = ServiceAuthBloc(_repository, _authLogInRepository,);
    _bloc.emptyState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainScreenDecoration(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              StreamBuilder(
                  stream: _bloc.streamController,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data is AuthEmptyState) {
                      return Column(
                        children: [
                          const AuthHeaderWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          const AuthMainImage(),
                          const _FormWidget(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.06),
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
                            onPressed: () {
                              _bloc.loadingLogIn('79516196915', '12345');
                            },
                            child: Text(
                              S.of(context).enter,
                              style: TextStyle(fontSize: 23),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
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
                            onPressed: () {
                              _bloc.loadingRegistration('79134322205', '12345');
                            },
                            child: Expanded(
                              child: Text(
                                S.of(context).registration,
                                style: const TextStyle(fontSize: 23),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    if (snapshot.data is AuthRegistrationLoadingState || snapshot.data is AuthLogInLoadingState) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              const AuthHeaderWidget(),
                              SizedBox(
                                height: 20,
                              ),
                              const AuthMainImage(),
                              const _FormWidget(),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.06),
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
                                onPressed: () {},
                                child: Text(
                                  S.of(context).enter,
                                  style: TextStyle(fontSize: 23),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
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
                                onPressed: () {
                                  _bloc.loadingRegistration('78889558899', '12345');
                                },
                                child: Expanded(
                                  child: Text(
                                    S.of(context).registration,
                                    style: const TextStyle(fontSize: 23),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(child: CircularProgressIndicator())
                        ],
                      );
                    }
                    if (snapshot.data is AuthRegistrationLoadedState || snapshot.data is AuthLogInLoadedState) {
                      Navigator.of(context)
                          .pushNamed(MainNavigationRouteName.mainScreen);
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _numberTextFieldController = TextEditingController();
    final _passwordTextFieldController = TextEditingController();
    final _height = MediaQuery.of(context).size.height;
    final _textStyle = TextStyle(fontSize: 16, color: Colors.white);
    return Column(
      children: [
        SizedBox(height: _height * 0.01),
        Text(S.of(context).enterYourPhoneNumber, style: _textStyle),
        SizedBox(height: _height * 0.01),
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
          controller: _numberTextFieldController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: _height * 0.02),
        Text(S.of(context).enterThePassword, style: _textStyle),
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
          controller: _passwordTextFieldController,
        ),
      ],
    );
  }
}
