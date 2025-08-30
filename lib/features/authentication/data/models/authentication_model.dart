import '../../domain/entities/authentication_entity.dart';

class AuthenticationModel extends AuthenticationEntity {
  AuthenticationModel ({
    required String id,
    required String accessToken,
    required String refreshToken,
  }) : super(
    id: id,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      id: json['_id'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}