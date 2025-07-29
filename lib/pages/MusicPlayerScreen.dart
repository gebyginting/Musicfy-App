import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';
import 'package:my_spotify/viewmodels/SongViewModel.dart';
import 'package:provider/provider.dart';

class MusicPlayerScreen extends StatelessWidget {
  final TrackModel song;

  const MusicPlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final songVm = context.watch<SongViewModel>();
    final favorites = songVm.favorites;

    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Now Playing",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child:
                    song.albumImage != null && song.albumImage.isNotEmpty
                        ? Image.network(
                          song.albumImage,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                        )
                        : const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 24),

            // Song Info
            Text(
              song.name,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              song.artist,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Optional Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => songVm.toggleFavorite(song),
                  icon: Icon(
                    songVm.isFavorite(song.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color:
                        songVm.isFavorite(song.id)
                            ? Colors.red
                            : Colors.white70,
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.playlist_add, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Slider
            const MusicSlider(),

            // Time Label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("1:23", style: TextStyle(color: Colors.white70)),
                Text("3:45", style: TextStyle(color: Colors.white70)),
              ],
            ),

            const SizedBox(height: 24),
            // Player Controls
            const PlayerControls(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class MusicSlider extends StatefulWidget {
  const MusicSlider({super.key});

  @override
  State<MusicSlider> createState() => _MusicSliderState();
}

class _MusicSliderState extends State<MusicSlider> {
  double _sliderValue = 0.4;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.white,
        inactiveTrackColor: Colors.white.withOpacity(0.3),
        thumbColor: Colors.white,
        overlayColor: Colors.white.withOpacity(0.1),
        trackHeight: 4,
      ),
      child: Slider(
        value: _sliderValue,
        min: 0,
        max: 1,
        onChanged: (value) {
          setState(() {
            _sliderValue = value;
          });
        },
      ),
    );
  }
}

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 36,
          icon: const Icon(Icons.skip_previous_rounded),
          color: Colors.white,
          onPressed: () {},
        ),
        const SizedBox(width: 32),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            iconSize: 36,
            icon: const Icon(Icons.play_arrow),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 32),
        IconButton(
          iconSize: 36,
          icon: const Icon(Icons.skip_next_rounded),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
