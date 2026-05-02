class AuthResult {
  const AuthResult.success() : message = null;

  const AuthResult.failure(this.message);

  final String? message;

  bool get isSuccess => message == null;
}
