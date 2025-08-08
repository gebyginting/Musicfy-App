import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/pages/MusicPlayerScreen.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';
import 'package:my_spotify/utils/constants.dart';
import 'package:my_spotify/viewmodels/AlbumViewModel.dart';
import 'package:my_spotify/widgets/AlbumTracksShimmerScreen.dart';
import 'package:my_spotify/widgets/ServerErrorWidget%20.dart';
import 'package:provider/provider.dart';

class AlbumTracksScreen extends StatefulWidget {
  final String albumId;

  const AlbumTracksScreen({super.key, required this.albumId});

  @override
  State<AlbumTracksScreen> createState() => _AlbumTracksScreenState();
}

class _AlbumTracksScreenState extends State<AlbumTracksScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AlbumViewModel>().loadAlbum(widget.albumId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumViewModel>(
      builder: (context, albumVM, _) {
        if (albumVM.isLoading) return const AlbumTracksShimmerScreen();

        if (albumVM.error != null) {
          if (albumVM.error!.contains("502")) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Servererrorwidget(
                onRetry: () => albumVM.loadAlbum(widget.albumId),
              ),
            );
          }

          return _buildError(albumVM.error!);
        }

        final album = albumVM.albumTracks;
        final albumInfo = albumVM.albumInfo;
        final albumTracks = albumVM.albumInfo?.tracks;

        if (albumInfo == null || albumTracks == null) {
          return _buildError('No tracks found');
        }

        return GradientScaffold(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AlbumHeader(album: albumInfo),
                const SizedBox(height: 24),
                ListView.separated(
                  itemCount: albumTracks.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final track = albumTracks[index];
                    return TrackTile(
                      index: index,
                      trackName: track.name,
                      artistName: albumInfo.artistName,
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => MusicPlayerScreen(
                                    song: track,
                                    imageUri: albumInfo.imageUrl,
                                  ),
                            ),
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildError(String message) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Error: $message',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class AlbumHeader extends StatelessWidget {
  final dynamic album;

  const AlbumHeader({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(album.imageUrl),
        _buildContent(context),
        _buildBottomGradient(),
        _buildActions(context),
        _buildBackButton(context),
      ],
    );
  }

  Widget _buildBackground(String imageUrl) {
    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(imageUrl, fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.6)),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      height: 360,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              album.imageUrl,
              height: 180,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            album.name,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            'Album by ${album.artistName}',
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomGradient() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 80,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black54, Colors.black87],
          ),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Row(
        children: [
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
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Album is being downloaded..."),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: Colors.white70,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder:
                        (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.share),
                              title: const Text('Share'),
                              onTap: () => Navigator.pop(context),
                            ),
                            ListTile(
                              leading: const Icon(Icons.report),
                              title: const Text("Report"),
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () {},
            child: const Icon(Icons.play_arrow, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class TrackTile extends StatelessWidget {
  final int index;
  final String trackName;
  final String artistName;
  final VoidCallback onTap;

  const TrackTile({
    super.key,
    required this.index,
    required this.trackName,
    required this.artistName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
          trackName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          artistName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.more_vert, color: Colors.white, size: 20),
        onTap: onTap,
      ),
    );
  }
}
