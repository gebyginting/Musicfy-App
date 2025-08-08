import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/pages/MusicPlayerScreen.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';

class PlayListScreen extends StatefulWidget {
  final PlaylistModel playlist;

  const PlayListScreen({super.key, required this.playlist});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  int? currentlyPlayingIndex;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [_buildSliverAppBar(context), _buildTrackList()],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    // TODO: fetch ulang playlist data
    await Future.delayed(const Duration(seconds: 1));
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF121350),
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final top = constraints.biggest.height;
          final isCollapsed =
              top <= kToolbarHeight + MediaQuery.of(context).padding.top;

          return FlexibleSpaceBar(
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isCollapsed ? 1.0 : 0.0,
              child: Text(
                widget.playlist.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            titlePadding: const EdgeInsetsDirectional.only(
              start: 72,
              bottom: 16,
            ),
            collapseMode: CollapseMode.parallax,
            background: _buildAppBarBackground(isCollapsed, context),
          );
        },
      ),
      leading: _buildBackButton(context),
    );
  }

  Widget _buildAppBarBackground(bool isCollapsed, BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(widget.playlist.images.first.url, fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
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
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity: isCollapsed ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.playlist.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "By ${widget.playlist.owner}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.4),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 16,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildTrackList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final parsedTrack = widget.playlist.tracks.items[index].track;
        final isPlaying = index == currentlyPlayingIndex;
        return TrackListItem(
          track: parsedTrack,
          isPlaying: isPlaying,
          onTap: () => _openMusicPlayer(parsedTrack),
          onPlayPause: () => _togglePlayPause(isPlaying, index),
        );
      }, childCount: widget.playlist.tracks.items.length),
    );
  }

  void _openMusicPlayer(TrackModel track) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MusicPlayerScreen(song: track)),
    );
  }

  void _togglePlayPause(bool isPlaying, int index) {
    setState(() {
      currentlyPlayingIndex = isPlaying ? null : index;
    });
  }
}

class TrackListItem extends StatelessWidget {
  final TrackModel track;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onPlayPause;

  const TrackListItem({
    super.key,
    required this.track,
    required this.isPlaying,
    required this.onTap,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              _buildAlbumCover(),
              const SizedBox(width: 14),
              _buildTrackInfo(),
              _buildPlayPauseButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumCover() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        track.albumImage,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTrackInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isPlaying)
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.music_note_outlined,
                    size: 16,
                    color: Colors.white60,
                  ),
                ),
              Expanded(
                child: Text(
                  track.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color:
                        isPlaying
                            ? const Color.fromARGB(255, 226, 173, 255)
                            : Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            track.artists.first.name.isNotEmpty
                ? track.artists.first.name
                : "Unknown Artist",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white60),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return InkWell(
      onTap: onPlayPause,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
