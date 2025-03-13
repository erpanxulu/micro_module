import '../models/auth_response.dart';

class AuthService {
  Future<AuthResponse> login(String username, String password) async {
    try {
      // Simulasi API call - ganti dengan implementasi sebenarnya
      await Future.delayed(const Duration(seconds: 1));

      // Contoh validasi sederhana
      if (username == 'admin' && password == 'password') {
        return AuthResponse.success('generated_token_$username');
      }

      return AuthResponse.error('Invalid credentials');
    } catch (e) {
      return AuthResponse.error('Authentication failed: $e');
    }
  }
}
