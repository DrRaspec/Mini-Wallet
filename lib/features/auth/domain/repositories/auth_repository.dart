import 'package:mini_wallet/features/auth/data/models/auth_response_model.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login(String username, String password);
  Future<AuthResponseModel> register(String username, String password);
  Future<AuthResponseModel> refreshToken(String refreshToken);
}
