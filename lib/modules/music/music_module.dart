import 'package:flutter/material.dart';
import './services/music_service.dart';
import './widgets/music_list.dart';

class MusicModule extends StatelessWidget {
  final String token;

  const MusicModule({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return MusicPage(token: token);
  }
}

class MusicPage extends StatefulWidget {
  final String token;

  const MusicPage({
    super.key,
    required this.token,
  });

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  late final MusicService _musicService;

  @override
  void initState() {
    super.initState();
    _musicService = MusicService(token: widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _musicService.getMusicList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          return MusicList(musicItems: snapshot.data!.listData);
        }
        return const Center(child: Text('No data available'));
      },
    );
  }
}
