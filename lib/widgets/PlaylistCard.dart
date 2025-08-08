import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/pages/PlayListScreen.dart';

class PlaylistCard extends StatelessWidget {
  final PlaylistModel playlist;

  const PlaylistCard({required this.playlist, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlayListScreen(playlist: playlist)),
        );
      },
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(playlist.images.first.url),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              playlist.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );
  }
}
