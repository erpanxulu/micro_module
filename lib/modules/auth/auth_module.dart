import 'package:flutter/material.dart';
import 'models/auth_response.dart';
import 'services/auth_service.dart';
import 'widgets/auth_form.dart';

typedef AuthCallback = void Function(AuthResponse response);

class AuthModule extends StatelessWidget {
  final AuthCallback? onAuthenticated;
  final AuthService? authService;

  const AuthModule({
    super.key,
    this.onAuthenticated,
    this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      onAuthenticated: onAuthenticated,
      authService: authService ?? AuthService(),
    );
  }
}

class AuthPage extends StatefulWidget {
  final AuthCallback? onAuthenticated;
  final AuthService authService;

  const AuthPage({
    super.key,
    this.onAuthenticated,
    required this.authService,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await widget.authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (mounted) {
        setState(
            () => _errorMessage = response.success ? null : response.message);
      }

      if (response.success && widget.onAuthenticated != null) {
        widget.onAuthenticated!(response);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Unexpected error occurred');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            AuthForm(
              isLoading: _isLoading,
              usernameController: _usernameController,
              passwordController: _passwordController,
              formKey: _formKey,
              onSubmit: _handleLogin,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
