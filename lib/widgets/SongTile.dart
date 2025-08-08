import 'package:flutter/material.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/pages/AlbumTracksScreen.dart';
import 'package:my_spotify/pages/ArtistScreen.dart';
import 'package:my_spotify/pages/MusicPlayerScreen.dart';

class SongTile extends StatelessWidget {
  final TrackModel song;

  const SongTile({required this.song, super.key});

  void _onMenuSelected(BuildContext context, String value) {
    switch (value) {
      case 'album':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AlbumTracksScreen(albumId: song.albumId),
          ),
        );
        break;
      case 'artist':
        _handleViewArtist(context, song.artists);
        break;
      case 'share':
        // Implementasi share (pakai share_plus atau lainnya)
        // Share.share('Now playing: ${song.name} by ${song.artists.first.name}');
        break;
    }
  }

  void _handleViewArtist(BuildContext context, List<Artist> artists) {
    if (artists.length == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ArtistScreen(artistId: artists[0].id),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children:
                artists.map((artist) {
                  return ListTile(
                    title: Text(artist.name),
                    onTap: () {
                      Navigator.pop(context); // close bottom sheet
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ArtistScreen(artistId: artist.id),
                        ),
                      );
                    },
                  );
                }).toList(),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
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
      title: Text(song.name, style: Theme.of(context).textTheme.titleSmall),
      subtitle: Text(
        song.artists.first.name,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, color: Colors.white, size: 20),
        onSelected: (value) => _onMenuSelected(context, value),
        itemBuilder:
            (context) => [
              const PopupMenuItem(child: Text('Lihat Album'), value: 'album'),
              const PopupMenuItem(value: 'artist', child: Text('Lihat Artis')),
              const PopupMenuItem(value: 'share', child: Text('Share')),
            ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MusicPlayerScreen(song: song)),
        );
      },
    );
  }
}
