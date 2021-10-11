

import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_provider.dart';

class UserLogInRepository {
  UserLogInProvider _userLogInProvider = UserLogInProvider();
  Future<String> postUserLogInData(Map<String, dynamic> jsonLogIn) => _userLogInProvider.postUserLogIn(jsonLogIn);
}
