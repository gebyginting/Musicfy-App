import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/pages/MusicPlayerScreen.dart';

class SongTile extends StatelessWidget {
  final TrackModel song;

  const SongTile({required this.song, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          song.albumImage,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(song.name, style: GoogleFonts.poppins(color: Colors.white)),
      subtitle: Text(
        song.artists.first.name,
        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
      ),
      trailing: const Icon(Icons.more_vert, color: Colors.white),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MusicPlayerScreen(song: song)),
        );
      },
    );
  }
}
