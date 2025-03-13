import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html';
import 'modules/auth/auth_module.dart';
import 'modules/auth/models/auth_response.dart';

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
  final String _baseUrl = 'https://dev.xulu.co.id';

  String get _iframeUrl =>
      _token != null ? '$_baseUrl?token=$_token' : _baseUrl;

  void _handleAuthenticated(AuthResponse response) {
    if (response.success) {
      setState(() => _token = response.token);
      _sendTokenToIframe();
    }
  }

  void _sendTokenToIframe() {
    if (_token != null) {
      window.postMessage({
        'type': 'TOKEN',
        'token': _token,
      }, '*');
    }
  }

  @override
  void initState() {
    super.initState();
    // Register the iframe element
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => IFrameElement()
        ..src = _iframeUrl
        ..style.border = 'none'
        ..style.height = '100%'
        ..style.width = '100%'
        ..allowFullscreen = true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Web Iframe Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          if (_token == null)
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: AuthModule(
                  onAuthenticated: _handleAuthenticated,
                ),
              ),
            ),
          if (_token != null)
            const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: HtmlElementView(
                viewType: 'iframeElement',
              ),
            ),
        ],
      ),
    );
  }
}
