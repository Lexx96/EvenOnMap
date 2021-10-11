
import 'package:event_on_map/auth/services/user_registration/user_registration_api_provider.dart';

class UserRegistrationRepository {
  UserRegistrationProvider _userRegistrationProvider = UserRegistrationProvider();
  Future<String> postUserRegistrationData(Map<String, dynamic> json) => _userRegistrationProvider.postUserRegistration(json);
}


class ResponseUserDada{}
