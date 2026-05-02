import 'package:mini_wallet/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:mini_wallet/features/auth/data/models/auth_response_model.dart';
import 'package:mini_wallet/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.remote});

  final AuthRemoteDs remote;

  @override
  Future<AuthResponseModel> login(String username, String password) {
    return remote.login(username, password);
  }

  @override
  Future<AuthResponseModel> refreshToken(String refreshToken) {
    return remote.refreshToken(refreshToken);
  }

  @override
  Future<AuthResponseModel> register(String username, String password) {
    return remote.register(username, password);
  }
}
