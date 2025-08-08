import 'package:flutter/material.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/pages/ArtistScreen.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';
import 'package:my_spotify/utils/Helper.dart';
import 'package:my_spotify/utils/constants.dart';
import 'package:my_spotify/viewmodels/SongViewModel.dart';
import 'package:provider/provider.dart';

class MusicPlayerScreen extends StatelessWidget {
  final TrackModel song;
  final String? imageUri;

  const MusicPlayerScreen({super.key, required this.song, this.imageUri});

  @override
  Widget build(BuildContext context) {
    final songVm = context.watch<SongViewModel>();
    final isFav = songVm.isFavorite(song.id);

    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Now Playing",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => showTrackOptions(context: context, track: song),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _AlbumArt(primaryImage: song.albumImage, fallbackImage: imageUri),
            const SizedBox(height: 12),
            ConditionalMarqueeText(
              text: song.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () {
                final artist = song.artists.firstOrNull;
                if (artist != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ArtistScreen(artistId: artist.id),
                    ),
                  );
                }
              },
              child: Text(
                song.artists.firstOrNull?.name ?? "Unknown Artist",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => songVm.toggleFavorite(song),
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.white70,
                  ),
                ),
                const SizedBox(width: 14),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.playlist_add, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const MusicSlider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("1:23", style: TextStyle(color: Colors.white70)),
                  Text("3:45", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const PlayerControls(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _AlbumArt extends StatelessWidget {
  final String? primaryImage;
  final String? fallbackImage;

  const _AlbumArt({this.primaryImage, this.fallbackImage});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageSize = screenHeight * 0.4;

    // Pilih gambar: kalau primary kosong/null → pakai fallback
    final imageToShow =
        (primaryImage != null && primaryImage!.isNotEmpty)
            ? primaryImage!
            : (fallbackImage ?? '');
    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child:
            imageToShow.isNotEmpty
                ? Image.network(
                  imageToShow,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                )
                : const Icon(Icons.broken_image, size: 100),
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
