import 'dart:async';
import 'package:event_on_map/auth/models/log_in/user_log_in.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_provider.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_api_repository.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_provider.dart';
import 'auth_bloc_state.dart';

class ServiceAuthBloc {
  final UserRegistrationRepository _authRegistrationRepository;
  final UserLogInRepository _authLogInRepository;

  ServiceAuthBloc(this._authRegistrationRepository,
      this._authLogInRepository,);

  final _streamController = StreamController<AuthBlocState>();

  Stream<AuthBlocState> get streamController => _streamController.stream;

  void emptyState() {
    _streamController.sink.add(AuthBlocState.emptyBlocState());
  }

  /// метод регистрации и получения данных
  void loadingRegistration(String phone, String password,) {
    _streamController.sink.add(AuthBlocState.loadingRegistration());
    try {
      UserRegistrationProvider().postUserRegistration(phone, password).then((
          responseJsonRegistration) {
        if (responseJsonRegistration.accessToken != null) {
          _streamController.sink.add(
              AuthBlocState.loadedRegistration(responseJsonRegistration));
        }
        else {
          _streamController.sink.add(AuthBlocState.emptyBlocState());
        }
      });
    }
    catch (_) {
      print('Ошибка выполнения запроса регистрации');
      _streamController.sink.add(AuthBlocState.emptyBlocState());
    }
  }

  /// метод авторизации и получения данных
  void loadingLogIn(String phone, String password) {
    _streamController.sink.add(AuthBlocState.loadingLogIn());
    try {
      UserLogInProvider().postUserLogIn(phone, password).then((
          responseJsonLogIn) {
        if (responseJsonLogIn is UserLogInModel && responseJsonLogIn.accessToken != null) {
          _streamController.sink.add(
              AuthBlocState.loadedLogIn(responseJsonLogIn));
        }
        else {
          
        }
      });
    }
    catch (_) {
      print('Ошибка выполнения запроса регистрации');
      _streamController.sink.add(AuthBlocState.emptyBlocState());
    }
  }

  void errorLengthNumber(){
    _streamController.sink.add(AuthBlocState.errorLengthNumber());
  }
  void errorLengthPassword(){
    _streamController.sink.add(AuthBlocState.errorLengthPassword());
  }

  void errorLengthLoginAndPassword(){
    _streamController.sink.add(AuthBlocState.errorLengthLoginAndPassword());
  }

  void dispose() {
    _streamController.close();
  }
}