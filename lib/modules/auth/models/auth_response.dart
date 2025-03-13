class AuthResponse {
  final String token;
  final String message;
  final bool success;

  AuthResponse({
    required this.token,
    required this.message,
    this.success = true,
  });

  factory AuthResponse.success(String token) {
    return AuthResponse(
      token: token,
      message: 'Authentication successful',
    );
  }

  factory AuthResponse.error(String message) {
    return AuthResponse(
      token: '',
      message: message,
      success: false,
    );
  }
}
