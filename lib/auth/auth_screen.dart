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
    return Scaffold(
      body: MainScreenDecoration(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder(
            stream: _bloc.streamController,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data is AuthLogInLoadedState ) {
                return ListView(
                  children: [
                    const AuthHeaderWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    const AuthMainImage(),
                    const FormWidget(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    const AuthTextAuthorization(),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          overlayColor: MaterialStateProperty.all(Colors.grey),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                          elevation: MaterialStateProperty.all(5),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          overlayColor: MaterialStateProperty.all(Colors.grey),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                          elevation: MaterialStateProperty.all(5),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
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
              if (snapshot.data is AuthRegistrationLoadingState ||
                  snapshot.data is AuthLogInLoadingState) {
                return Stack(
                  children: [
                    ListView(
                      children: [
                        const AuthHeaderWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        const AuthMainImage(),
                        const FormWidget(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06),
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
                          onPressed: () {
                            _bloc.loadingRegistration('78889558999', '12345');
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
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              }
              if (snapshot.data is AuthRegistrationLoadedState ||
                  snapshot.data is EmptyBlocState) {
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


