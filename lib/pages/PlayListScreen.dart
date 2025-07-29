import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/pages/MusicPlayerScreen.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';

class PlayListScreen extends StatefulWidget {
  final String playlistTitle;
  final String playlistOwner;
  final List<TrackModel> tracks;
  final String artistImage;

  const PlayListScreen({
    super.key,
    required this.playlistTitle,
    required this.playlistOwner,
    required this.tracks,
    required this.artistImage,
  });

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  int? currentlyPlayingIndex;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Stack(
            children: [
              // Artist Banner
              SizedBox(
                height: 400,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  child: Image.network(widget.artistImage, fit: BoxFit.cover),
                ),
              ),
              // Gradient Overlay
              Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
              // Back button + Menu
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      BackButton(color: Colors.white),
                      Icon(Icons.more_vert, color: Colors.white),
                    ],
                  ),
                ),
              ),
              // Title
              Positioned(
                bottom: 32,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.playlistTitle,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.playlistOwner,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // // Search bar
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     decoration: BoxDecoration(
          //       color: const Color(0xFF1F1F1F),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: TextField(
          //       style: const TextStyle(color: Colors.white),
          //       decoration: InputDecoration(
          //         icon: const Icon(Icons.search, color: Colors.white70),
          //         hintText: "Search",
          //         hintStyle: GoogleFonts.poppins(color: Colors.white54),
          //         border: InputBorder.none,
          //       ),
          //     ),
          //   ),
          // ),

          // Song list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: widget.tracks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final track = widget.tracks[index];
                final isPlaying = index == currentlyPlayingIndex;

                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MusicPlayerScreen(song: track),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isPlaying
                              ? const Color(0xFF121350)
                              : const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        // Album Art
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            track.albumImage,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Song Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                track.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight:
                                      isPlaying
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                track.artist.isNotEmpty
                                    ? track.artist
                                    : "Unknown Artist",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Play button
                        IconButton(
                          onPressed: () {
                            setState(() {
                              currentlyPlayingIndex = isPlaying ? null : index;
                            });
                          },
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (child, animation) => ScaleTransition(
                                  scale: animation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                ),
                            child: Icon(
                              isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                              color: Colors.white,
                              size: 32,
                              key: ValueKey<bool>(
                                isPlaying,
                              ), // agar AnimatedSwitcher bisa detek perubahan
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
