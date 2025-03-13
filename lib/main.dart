import 'package:flutter/material.dart';
import 'modules/auth/auth_module.dart';
import 'modules/auth/models/auth_response.dart';
import 'modules/music/music.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Iframe Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _token;

  void _handleAuthenticated(AuthResponse response) async {
    if (response.success) {
      setState(() => _token = response.token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Web Iframe Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          if (_token == null)
            AuthModule(
              onAuthenticated: _handleAuthenticated,
            ),
          if (_token != null)
            Expanded(
              child: MusicModule(token: _token!),
            ),
        ],
      ),
    );
  }
}
