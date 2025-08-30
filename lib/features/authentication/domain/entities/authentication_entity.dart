class AuthenticationEntity {
  final String id;
  final String accessToken;
  final String refreshToken;

  AuthenticationEntity({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
  });
}