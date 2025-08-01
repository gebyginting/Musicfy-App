import 'package:flutter/material.dart';
import 'package:my_spotify/pages/ArtistScreen.dart';
import 'package:my_spotify/pages/FavoriteScreen.dart';
import 'package:my_spotify/pages/MusicPlayerScreen.dart';
import 'package:my_spotify/pages/PlayListScreen.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/utils/constants.dart';
import 'package:my_spotify/viewmodels/ArtistViewModel.dart';
import 'package:my_spotify/viewmodels/PlaylistViewModel.dart';
import 'package:my_spotify/viewmodels/SongViewModel.dart';
import 'package:my_spotify/widgets/GenreChip.dart';
import 'package:my_spotify/widgets/PlaylistCard.dart';
import 'package:my_spotify/widgets/SearchBarDelegate.dart';
import 'package:my_spotify/widgets/ShimmerBox.dart';
import 'package:my_spotify/widgets/SongTile.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });

    Future.microtask(() {
      // Load Tracks
      Provider.of<SongViewModel>(context, listen: false).loadSongsByIds([
        '3NxJKoYi9WMBuZdk4UdJuK',
        '7qCAVkHWZkF44OzOUKf8Cr',
        '1ZLrDPgR7mvuTco3rQK8Pk',
        '7j4Mlml9lBzbswaP6ahtYy',
        '3QaPy1KgI7nu9FJEQUgn6h',
        // '6dOtVTDdiauQNBQEDOtlAB',
        // '2NttzQ2kuVFFmEa8q4rsbu',
        // '2dhhLFPhKgHI6uSBmTuNUJ',
        // '1juHIWqgFiDFAKuEBP24Lt',
      ]);

      Provider.of<ArtistViewModel>(
        context,
        listen: false,
      ).loadArtistListInformation([
        '1Xyo4u8uXC1ZmMpatF05PJ', // The Weeknd
        '5ZsFI1h6hIdQRw2ti0hz81', // Neyo
        '3eVa5w3URK5duf6eyVDbu9', // Libianca
        '6VuMaDnrHyPL1p4EHjYLi7', // Charlie Puth
        '0du5cEVh5yTK9QJze8zA0C', // Bruno Mars
        '4nDoRrQiYLoBzwC5BhVJzF', // Camila Cabello
        '6qqNVTkY8uBg9cP3Jd7DAH', // Billie Eilish
        '3qNVuliS40BLgXGxhdBdqu', // Mahen
      ]);

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
        '12XmTwbx8e6c47QfecTIlf',
        '7HYUSfgjzjzA5IKqhUbOfR',
        '4AolIdPhPRofTBK5neaq63',
        '1aJXh7Y3vzdyMcbUaLoF89',
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 80,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      kGreeting,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FavoriteScreen(),
                              ),
                            );
                          },
                        ),
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/avatar.jpg'),
                          radius: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: SearchBarDelegate(
              controller: _searchController,
              onChanged: (value) {
                _searchQueryNotifier.value = value.toLowerCase();
              },
              onClear: () {
                _searchController.clear();
                FocusScope.of(context).unfocus();
                _searchQueryNotifier.value = "";
              },
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  Text(
                    kGenres,
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
                      children: const [
                        GenreChip("Pop"),
                        GenreChip("Lofi"),
                        GenreChip("Rock"),
                        GenreChip("Jazz"),
                        GenreChip("Chill"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text(
                    "Popular Artists",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    height: 160,
                    child: Consumer<ArtistViewModel>(
                      builder: (context, artistVM, _) {
                        if (artistVM.isLoading) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            separatorBuilder:
                                (_, __) => const SizedBox(width: 16),
                            itemBuilder: (context, _) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade400,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.white12,
                                    ),
                                    const SizedBox(height: 6),
                                  ],
                                ),
                              );
                            },
                          );
                        }

                        if (artistVM.error != null) {
                          return const Text(
                            'Failed to load artist list',
                            style: TextStyle(color: Colors.red),
                          );
                        }

                        if (artistVM.artistList.isEmpty) {
                          return const Text(
                            'No artist found',
                            style: TextStyle(color: Colors.white),
                          );
                        }

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: artistVM.artistList.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final artist = artistVM.artistList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            ArtistScreen(artistId: artist.id),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.deepPurpleAccent
                                              .withOpacity(0.4),
                                          blurRadius: 16,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundImage: NetworkImage(
                                        artist.imageUrl,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      artist.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Text(
                    kRecommended,
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
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            separatorBuilder:
                                (_, __) => const SizedBox(width: 16),
                            itemBuilder:
                                (_, __) =>
                                    const ShimmerBox(height: 180, width: 140),
                          );
                        }

                        if (playlistVM.error != null) {
                          return const Text(
                            'Failed to load playlists',
                            style: TextStyle(color: Colors.red),
                          );
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
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final playlist = playlistVM.playlists[index];
                            return PlaylistCard(playlist: playlist);
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text(
                    kRecentlyPlayed,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Consumer<SongViewModel>(
                    builder: (context, trackVM, _) {
                      if (trackVM.isLoading) {
                        return Column(
                          children: List.generate(
                            5,
                            (index) => const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: ShimmerBox(
                                height: 64,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        );
                      }

                      final filteredSongs =
                          _searchQueryNotifier.value.isEmpty
                              ? trackVM.songs
                              : trackVM.songs.where((track) {
                                final name = track.name.toLowerCase();
                                final artist =
                                    track.artists.first.name.toLowerCase();
                                return name.contains(
                                      _searchQueryNotifier.value,
                                    ) ||
                                    artist.contains(_searchQueryNotifier.value);
                              }).toList();

                      if (filteredSongs.isEmpty) {
                        return const Text(
                          "No songs found",
                          style: TextStyle(color: Colors.white70),
                        );
                      }

                      return ListView.separated(
                        controller: _scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredSongs.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder:
                            (context, index) =>
                                SongTile(song: filteredSongs[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchQueryNotifier.dispose();
    super.dispose();
  }
}
