import 'dart:async';
import 'dart:convert';
import 'package:event_on_map/auth/models/log_in/user_log_in.dart';
import 'package:event_on_map/auth/models/registration/user_registration.dart';
import 'package:event_on_map/auth/services/json_data_coder/json_data_coder.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_repository.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_repository.dart';
import 'auht_bloc_state.dart';

class ServiceAuthBloc {
  final UserRegistrationRepository _authRegistrationRepository;
  final UserLogInRepository _authLogInRepository;

  ServiceAuthBloc(
    this._authRegistrationRepository,
    this._authLogInRepository,
  );

  final _streamController = StreamController<AuthBlocState>();

  Stream<AuthBlocState> get streamController => _streamController.stream;

  void emptyState() {
    _streamController.sink.add(AuthBlocState.empty());
  }

  void loadingRegistration(String phone, String password,) {
    _streamController.sink.add(AuthBlocState.loadingRegistration());

    try{
      /// метод регистрации и получения данных
      JsonDataCoder().userRegistrationPost(phone, password, _authRegistrationRepository,).then((value) {});
    }
    catch(_){
      print('Ошибка выполнения запроса регистрации');
    }
    _streamController.sink.add(AuthBlocState.loadedRegistration());
  }

  void loadingLogIn(String phone, String password) {
    _streamController.sink.add(AuthBlocState.loadingLogIn());

    try {
      /// метод авторизации и получения данных
      JsonDataCoder().userLogInPost(phone, password, _authLogInRepository).then((value) {});

    } catch(_){
      print('Ошибка выполнения запроса авторизации');
    }
    _streamController.sink.add(AuthBlocState.loadedLogIn());
  }

  void dispose() {
    _streamController.close();
  }
}

/*
метод регистрации
    // Map<String, dynamic> _registrationModel =
    //     UserRegistrationModel(phone: phone, password: password).toJson();
    //
    // _authRegistrationRepository.postUserRegistrationData(_registrationModel).then((jsonStringRegistration) {
    //   final listJsonRegistration = jsonDecode(jsonStringRegistration) as Map<String, dynamic>;
    //   final jsonRegistration = UserRegistrationModel.fromJson(listJsonRegistration);
    //   print(jsonRegistration.userData!.phone);
    // });


метод авторизации
    // Map<String, dynamic> _logInModel = UserLogInModel(phone: phone, password: password).toJson();
    // _authLogInRepository.postUserLogInData(_logInModel).then((jsonStringLogIn) {
    //   final listJsonLogIn = jsonDecode(jsonStringLogIn) as Map<String, dynamic>;
    //   final json = UserLogInModel.fromJson(listJsonLogIn);
    //   print(json);
    // });

 */