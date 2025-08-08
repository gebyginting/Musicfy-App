import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/pages/AlbumTracksScreen.dart';
import 'package:my_spotify/pages/ArtistAlbumScreen.dart';
import 'package:my_spotify/pages/MusicPlayerScreen.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';
import 'package:my_spotify/utils/constants.dart';
import 'package:my_spotify/viewmodels/ArtistViewModel.dart';
import 'package:my_spotify/widgets/ArtistShimmerScreen.dart';
import 'package:my_spotify/widgets/ServerErrorWidget%20.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatefulWidget {
  final String artistId;

  const ArtistScreen({super.key, required this.artistId});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArtistViewModel>().loadArtist(widget.artistId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) return const ArtistShimmerScreen();

        if (vm.error != null) {
          return _buildError(context, vm.error!);
        }

        if (vm.artist == null) {
          return _buildNoData();
        }

        return GradientScaffold(
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                _buildAppBar(context, vm),
                _buildNewReleasesHeader(context, vm),
                _buildHorizontalAlbums(context, vm),
                _buildTopTracksHeader(context),
                _buildTopTracksList(context, vm),
              ],
            ),
          ),
        );
      },
    );
  }

  // App Bar with background and artist info
  Widget _buildAppBar(BuildContext context, ArtistViewModel vm) {
    final artist = vm.artist!;
    final albums = vm.albums;

    return SliverAppBar(
      pinned: true,
      expandedHeight: 320,
      backgroundColor: const Color(0xFF121350),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final isCollapsed =
              constraints.biggest.height <=
              kToolbarHeight + MediaQuery.of(context).padding.top;

          return FlexibleSpaceBar(
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isCollapsed ? 1.0 : 0.0,
              child: Text(
                artist.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            titlePadding: const EdgeInsetsDirectional.only(
              start: 72,
              bottom: 16,
            ),
            collapseMode: CollapseMode.parallax,
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(artist.imageUrl, fit: BoxFit.cover),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artist.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '12 tracks • ${albums.length} albums',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 12, top: 4),
        child: CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.4),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }

  Widget _buildNewReleasesHeader(BuildContext context, ArtistViewModel vm) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: 8,
        ),
        child: Row(
          children: [
            Text(
              'New Releases',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => AllAlbumsScreen(
                          albums: vm.albums,
                          artistName: vm.artist?.name ?? '',
                        ),
                  ),
                );
              },
              child: Text(
                'View All',
                style: GoogleFonts.poppins(
                  color: Colors.greenAccent,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalAlbums(BuildContext context, ArtistViewModel vm) {
    final albums = vm.albums.take(4).toList();

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          itemCount: albums.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (_, index) {
            final album = albums[index];
            return GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AlbumTracksScreen(albumId: album.id),
                    ),
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      album.imageUrl,
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 130,
                    child: Text(
                      album.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Text(
                      album.releaseDate,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopTracksHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: 8,
        ),
        child: Text(
          'Top Tracks',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget _buildTopTracksList(BuildContext context, ArtistViewModel vm) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final track = vm.topTracks[index];

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MusicPlayerScreen(song: track),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          track.albumImage,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatDuration(track.durationMs),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white54,
                  size: 20,
                ),
                onPressed: () => _showTrackOptions(context),
              ),
            ],
          ),
        );
      }, childCount: vm.topTracks.length),
    );
  }

  void _showTrackOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.playlist_add, color: Colors.white),
              title: const Text(
                'Tambahkan ke Playlist',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white),
              title: const Text(
                'Bagikan',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border, color: Colors.white),
              title: const Text(
                'Favoritkan',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget _buildError(BuildContext context, String error) {
    if (error.contains("502")) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Servererrorwidget(
          onRetry:
              () => context.read<ArtistViewModel>().loadArtist(widget.artistId),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Error: $error',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildNoData() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text('No artist data', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  String _formatDuration(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
