import 'dart:async';
import 'dart:convert';
import 'package:event_on_map/auth_sign_in/bloc/user_registration_state.dart';
import 'package:event_on_map/auth_sign_in/models/user_data.dart';
import 'package:event_on_map/auth_sign_in/models/user_registration.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_repository.dart';

class ServiceSignInBloc {
  late final UserRegistrationRepository _authRepository;

  ServiceSignInBloc(this._authRepository);

  final _streamAuthController = StreamController<SignInBlocState>();

  Stream<SignInBlocState> get streamAuthGetter => _streamAuthController.stream;

  void emptyState() {
    _streamAuthController.sink.add(SignInBlocState.empty());
  }

  void loadingBloc(String phone, String password) {
    _streamAuthController.sink.add(SignInBlocState.loading());

    Map<String, dynamic> _model =
        UserRegistrationModel(phone: phone, password: password).toJson();

    _authRepository.postUserRegistrationData(_model).then((jsonString) {
      final json =
          jsonDecode(jsonDecode(jsonString)['user-data']) as List<dynamic>;
      final List<UserData> user = json
          .map((dynamic e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList();
      print(user[0].phone.toString());

      _streamAuthController.sink.add(SignInBlocState.response(user));
    });
  }

  void dispose() {
    _streamAuthController.close();
  }

}

