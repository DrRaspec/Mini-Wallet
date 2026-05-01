class AuthResponseModel {
  String? userId;
  String? username;
  String? accessToken;
  String? refreshToken;
  String? tokenType;

  AuthResponseModel({
    this.userId,
    this.username,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
  });

  @override
  String toString() {
    return 'AuthResponseModel(userId: $userId, username: $username, accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType)';
  }

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      userId: json['userId'] as String?,
      username: json['username'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      tokenType: json['tokenType'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'username': username,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'tokenType': tokenType,
  };

  AuthResponseModel copyWith({
    String? userId,
    String? username,
    String? accessToken,
    String? refreshToken,
    String? tokenType,
  }) {
    return AuthResponseModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      tokenType: tokenType ?? this.tokenType,
    );
  }
}
