import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';
import 'package:my_spotify/viewmodels/AlbumViewModel.dart';
import 'package:provider/provider.dart';

class AlbumTracksScreen extends StatefulWidget {
  final AlbumModel album;
  const AlbumTracksScreen({super.key, required this.album});

  @override
  State<AlbumTracksScreen> createState() => _AlbumTracksScreenState();
}

class _AlbumTracksScreenState extends State<AlbumTracksScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AlbumViewModel>(
        context,
        listen: false,
      ).loadAlbumTracks(widget.album.id);
    });
  }

  String formatDuration(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumViewModel>(
      builder: (context, albumVM, child) {
        if (albumVM.isLoading) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }

        if (albumVM.error != null) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                'Error: ${albumVM.error}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final album = albumVM.album;
        if (album == null) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                'No tracks found',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return GradientScaffold(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Bagian header dengan Stack (gambar redup + cover + info)
                Stack(
                  children: [
                    // Background redup
                    Container(
                      height: 320,
                      width: double.infinity,
                      child: Image.network(
                        widget.album.imageUrl,
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.4),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),

                    // Isi foreground (cover album + nama)
                    Container(
                      height: 320,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              widget.album.imageUrl,
                              height: 140,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.album.name,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Album by ${widget.album.artistName}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // Tombol kembali di pojok kiri atas
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Tombol play
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // 🔴 Action Icons di kiri
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            color: Colors.white70,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.download),
                            color: Colors.white70,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            color: Colors.white70,
                            onPressed: () {},
                          ),
                        ],
                      ),

                      const Spacer(), // 🔸 Spacer untuk mendorong tombol play ke kanan
                      // 🔵 Tombol Play di kanan
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.deepPurpleAccent,
                        onPressed: () {},
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Daftar lagu
                ListView.separated(
                  itemCount: album.items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final track = album.items[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        title: Text(
                          track.name,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          widget.album.artistName,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.more_vert,
                          color: Colors.white54,
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
