import 'package:flutter/material.dart';
import '../models/music_response.dart';

class MusicList extends StatelessWidget {
  final List<MusicItem> musicItems;

  const MusicList({
    super.key,
    required this.musicItems,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: musicItems.length,
      itemBuilder: (context, index) {
        final item = musicItems[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(item.originalName),
            subtitle: Text(
                'Size: ${(item.mediaSize / 1024 / 1024).toStringAsFixed(2)} MB'),
            trailing: const Icon(Icons.play_arrow),
            onTap: () {
              // Implementasi pemutaran musik
              print('Playing: ${item.mediaUrl}');
            },
          ),
        );
      },
    );
  }
}
