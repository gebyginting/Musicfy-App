import 'package:flutter/material.dart';
import 'package:my_spotify/pages/MusicPlayerScreen.dart';
import 'package:my_spotify/pages/PlayListScreen.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/viewmodels/PlaylistViewModel.dart';
import 'package:my_spotify/viewmodels/SongViewModel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // Load Tracks
      Provider.of<SongViewModel>(
        context,
        listen: false,
      ).loadSongsByIds(['3NxJKoYi9WMBuZdk4UdJuK', '7qCAVkHWZkF44OzOUKf8Cr']);

      // Load Playlist
      Provider.of<Playlistviewmodel>(
        context,
        listen: false,
      ).loadMultiplePlaylists([
        '6QldmPHZUUPmcTy07FsyPI',
        '7eYBwlYMkT2VLwzMvFz3Gj',
        '68JXTKfqFZEWO1DQRdVndh',
        '2JtMCwq7aSoxf4EACEqZL9',
        '1a7oOOBs9p9ib50SHd6nWf',
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello, Geby 👋',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                  radius: 20,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.white70),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Search your vibe...",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Categories
            Text(
              "Genres",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  genreChip("Pop"),
                  genreChip("Lofi"),
                  genreChip("Rock"),
                  genreChip("Jazz"),
                  genreChip("Chill"),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Playlist Recommendations
            Text(
              "Recommended for you",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: Consumer<Playlistviewmodel>(
                builder: (context, playlistVM, _) {
                  if (playlistVM.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (playlistVM.playlists.isEmpty) {
                    return const Text(
                      'No tracks found',
                      style: TextStyle(color: Colors.white),
                    );
                  }

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: playlistVM.playlists.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final playlist = playlistVM.playlists[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => PlayListScreen(
                                    playlistTitle: playlist.name,
                                    tracks:
                                        playlist.tracks.items
                                            .map((item) => item.track)
                                            .toList(),

                                    artistImage:
                                        playlist.images.isNotEmpty
                                            ? playlist.images.first.url
                                            : '',
                                    playlistOwner: playlist.owner.displayName,
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          width: 140,
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
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Recently Played
            Text(
              "Recently played",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Consumer<SongViewModel>(
              builder: (context, trackVM, child) {
                if (trackVM.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  children:
                      trackVM.songs.map((track) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            tileColor: Colors.white12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                track.albumImage,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              track.name,
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            subtitle: Text(
                              track.artist,
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => MusicPlayerScreen(song: track),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget genreChip(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(name, style: GoogleFonts.poppins(color: Colors.white)),
    );
  }
}
