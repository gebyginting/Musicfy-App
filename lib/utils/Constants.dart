const double kDefaultPadding = 14;
const String kGreeting = 'Hello, Geby 👋';
const String kGenres = 'Genres';
const String kRecommended = 'Recommended for you';
const String kRecentlyPlayed = 'Recently played';

const List<String> sampleTrackIds = [
  '3NxJKoYi9WMBuZdk4UdJuK',
  '7qCAVkHWZkF44OzOUKf8Cr',
  '1ZLrDPgR7mvuTco3rQK8Pk',
  '7j4Mlml9lBzbswaP6ahtYy',
  '3QaPy1KgI7nu9FJEQUgn6h',
];

const List<String> sampleArtistIds = [
  '1Xyo4u8uXC1ZmMpatF05PJ',
  '5ZsFI1h6hIdQRw2ti0hz81',
  '3eVa5w3URK5duf6eyVDbu9',
  '6VuMaDnrHyPL1p4EHjYLi7',
  '0du5cEVh5yTK9QJze8zA0C',
  '4nDoRrQiYLoBzwC5BhVJzF',
  '6qqNVTkY8uBg9cP3Jd7DAH',
  '3qNVuliS40BLgXGxhdBdqu',
];

const List<String> samplePlaylistIds = [
  '6QldmPHZUUPmcTy07FsyPI',
  '7eYBwlYMkT2VLwzMvFz3Gj',
  '68JXTKfqFZEWO1DQRdVndh',
  '2JtMCwq7aSoxf4EACEqZL9',
  '1a7oOOBs9p9ib50SHd6nWf',
  '12XmTwbx8e6c47QfecTIlf',
  '7HYUSfgjzjzA5IKqhUbOfR',
  '4AolIdPhPRofTBK5neaq63',
  '1aJXh7Y3vzdyMcbUaLoF89',
];

// import 'package:flutter/material.dart';
// import 'package:my_spotify/pages/ArtistScreen.dart';
// import 'package:my_spotify/pages/FavoriteScreen.dart';
// import 'package:my_spotify/utils/GradientScaffold%20.dart';
// import 'package:my_spotify/utils/constants.dart';
// import 'package:my_spotify/viewmodels/ArtistViewModel.dart';
// import 'package:my_spotify/viewmodels/PlaylistViewModel.dart';
// import 'package:my_spotify/viewmodels/SongViewModel.dart';
// import 'package:my_spotify/widgets/GenreChip.dart';
// import 'package:my_spotify/widgets/PlaylistCard.dart';
// import 'package:my_spotify/widgets/SearchBarDelegate.dart';
// import 'package:my_spotify/widgets/ShimmerBox.dart';
// import 'package:my_spotify/widgets/SongTile.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController _searchController = TextEditingController();
//   final ValueNotifier<String> _searchQueryNotifier = ValueNotifier<String>("");

//   @override
//   void initState() {
//     super.initState();

//     _searchController.addListener(() {
//       setState(() {});
//     });

//     Future.microtask(() {
//       // Load Tracks
//       Provider.of<SongViewModel>(context, listen: false).loadSongsByIds([
//         '3NxJKoYi9WMBuZdk4UdJuK',
//         '7qCAVkHWZkF44OzOUKf8Cr',
//         '1ZLrDPgR7mvuTco3rQK8Pk',
//         '7j4Mlml9lBzbswaP6ahtYy',
//         '3QaPy1KgI7nu9FJEQUgn6h',
//         // '6dOtVTDdiauQNBQEDOtlAB',
//         // '2NttzQ2kuVFFmEa8q4rsbu',
//         // '2dhhLFPhKgHI6uSBmTuNUJ',
//         // '1juHIWqgFiDFAKuEBP24Lt',
//       ]);

//       Provider.of<ArtistViewModel>(context, listen: false).loadArtists([
//         '1Xyo4u8uXC1ZmMpatF05PJ', // The Weeknd
//         '5ZsFI1h6hIdQRw2ti0hz81', // Neyo
//         '3eVa5w3URK5duf6eyVDbu9', // Libianca
//         '6VuMaDnrHyPL1p4EHjYLi7', // Charlie Puth
//         '0du5cEVh5yTK9QJze8zA0C', // Bruno Mars
//         '4nDoRrQiYLoBzwC5BhVJzF', // Camila Cabello
//         '6qqNVTkY8uBg9cP3Jd7DAH', // Billie Eilish
//         '3qNVuliS40BLgXGxhdBdqu', // Mahen
//       ]);

//       // Load Playlist
//       Provider.of<PlaylistViewModel>(context, listen: false).loadPlaylists([
//         '6QldmPHZUUPmcTy07FsyPI',
//         '7eYBwlYMkT2VLwzMvFz3Gj',
//         '68JXTKfqFZEWO1DQRdVndh',
//         '2JtMCwq7aSoxf4EACEqZL9',
//         '1a7oOOBs9p9ib50SHd6nWf',
//         '12XmTwbx8e6c47QfecTIlf',
//         '7HYUSfgjzjzA5IKqhUbOfR',
//         '4AolIdPhPRofTBK5neaq63',
//         '1aJXh7Y3vzdyMcbUaLoF89',
//       ]);
//     });
//   }

//   Future<void> _onRefresh() async {
//     try {
//       await Provider.of<SongViewModel>(context, listen: false).loadSongsByIds([
//         '3NxJKoYi9WMBuZdk4UdJuK',
//         '7qCAVkHWZkF44OzOUKf8Cr',
//         '1ZLrDPgR7mvuTco3rQK8Pk',
//         '7j4Mlml9lBzbswaP6ahtYy',
//         '3QaPy1KgI7nu9FJEQUgn6h',
//       ]);
//       await Provider.of<ArtistViewModel>(context, listen: false).loadArtists([
//         '1Xyo4u8uXC1ZmMpatF05PJ',
//         '5ZsFI1h6hIdQRw2ti0hz81',
//         '3eVa5w3URK5duf6eyVDbu9',
//         '6VuMaDnrHyPL1p4EHjYLi7',
//         '0du5cEVh5yTK9QJze8zA0C',
//         '4nDoRrQiYLoBzwC5BhVJzF',
//         '6qqNVTkY8uBg9cP3Jd7DAH',
//         '3qNVuliS40BLgXGxhdBdqu',
//       ]);
//       await Provider.of<PlaylistViewModel>(
//         context,
//         listen: false,
//       ).loadPlaylists([
//         '6QldmPHZUUPmcTy07FsyPI',
//         '7eYBwlYMkT2VLwzMvFz3Gj',
//         '68JXTKfqFZEWO1DQRdVndh',
//         '2JtMCwq7aSoxf4EACEqZL9',
//         '1a7oOOBs9p9ib50SHd6nWf',
//         '12XmTwbx8e6c47QfecTIlf',
//         '7HYUSfgjzjzA5IKqhUbOfR',
//         '4AolIdPhPRofTBK5neaq63',
//         '1aJXh7Y3vzdyMcbUaLoF89',
//       ]);
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Gagal memuat ulang data. Periksa koneksi internet."),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GradientScaffold(
//       child: RefreshIndicator(
//         onRefresh: _onRefresh,
//         edgeOffset: 100,
//         backgroundColor: Colors.deepPurpleAccent,
//         color: Colors.white,
//         child: CustomScrollView(
//           controller: _scrollController,
//           physics: const AlwaysScrollableScrollPhysics(),
//           slivers: [
//             SliverAppBar(
//               pinned: false,
//               expandedHeight: 72,
//               backgroundColor: Colors.transparent,
//               flexibleSpace: LayoutBuilder(
//                 builder: (context, constraints) {
//                   final progress =
//                       (constraints.maxHeight - kToolbarHeight) /
//                       (72 - kToolbarHeight);
//                   final opacity = progress.clamp(
//                     0.0,
//                     1.0,
//                   ); // nilai dari 1.0 (penuh) sampai 0.0 (hilang)

//                   return Opacity(
//                     opacity: opacity,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Musicfy',
//                                 style: TextStyle(
//                                   fontSize: 21,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: 28,
//                                     height: 4,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(2),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Container(
//                                     width: 10,
//                                     height: 4,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white54,
//                                       borderRadius: BorderRadius.circular(
//                                         2,
//                                       ), // supaya seragam bulatnya
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.favorite,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const FavoriteScreen(),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             SliverPersistentHeader(
//               pinned: true,
//               delegate: SearchBarDelegate(
//                 controller: _searchController,
//                 onChanged: (value) {
//                   _searchQueryNotifier.value = value.toLowerCase();
//                 },
//                 onClear: () {
//                   _searchController.clear();
//                   FocusScope.of(context).unfocus();
//                   _searchQueryNotifier.value = "";
//                 },
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   right: kDefaultPadding,
//                   left: kDefaultPadding,
//                   bottom: kDefaultPadding,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       kGenres,
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: 40,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: const [
//                           Center(child: GenreChip("Pop")),
//                           Center(child: GenreChip("Lofi")),
//                           Center(child: GenreChip("Rock")),
//                           Center(child: GenreChip("Jazz")),
//                           Center(child: GenreChip("Chill")),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     Text(
//                       "Popular Artists",
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     const SizedBox(height: 16),

//                     SizedBox(
//                       height: 140,
//                       child: Consumer<ArtistViewModel>(
//                         builder: (context, artistVM, _) {
//                           if (artistVM.isLoading) {
//                             return ListView.separated(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: 10,
//                               separatorBuilder:
//                                   (_, __) => const SizedBox(width: 16),
//                               itemBuilder: (context, _) {
//                                 return Shimmer.fromColors(
//                                   baseColor: Colors.grey.shade700,
//                                   highlightColor: Colors.grey.shade400,
//                                   child: Column(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 45,
//                                         backgroundColor: Colors.white12,
//                                       ),
//                                       const SizedBox(height: 6),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           }

//                           if (artistVM.error != null) {
//                             return const Text(
//                               'Failed to load artist list',
//                               style: TextStyle(color: Colors.red),
//                             );
//                           }

//                           if (artistVM.artistList.isEmpty) {
//                             return const Text(
//                               'No artist found',
//                               style: TextStyle(color: Colors.white),
//                             );
//                           }

//                           return ListView.separated(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: artistVM.artistList.length,
//                             separatorBuilder:
//                                 (_, __) => const SizedBox(width: 16),
//                             itemBuilder: (context, index) {
//                               final artist = artistVM.artistList[index];
//                               return GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (_) =>
//                                               ArtistScreen(artistId: artist.id),
//                                     ),
//                                   );
//                                 },
//                                 child: Column(
//                                   children: [
//                                     AnimatedContainer(
//                                       duration: const Duration(
//                                         milliseconds: 200,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.deepPurpleAccent
//                                                 .withOpacity(0.4),
//                                             blurRadius: 16,
//                                             offset: const Offset(0, 5),
//                                           ),
//                                         ],
//                                       ),
//                                       child: CircleAvatar(
//                                         radius: 45,
//                                         backgroundImage: NetworkImage(
//                                           artist.imageUrl,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Text(
//                                       artist.name,
//                                       style:
//                                           Theme.of(
//                                             context,
//                                           ).textTheme.titleSmall,
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),

//                     Text(
//                       kRecommended,
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: 160,
//                       child: Consumer<PlaylistViewModel>(
//                         builder: (context, playlistVM, _) {
//                           if (playlistVM.isLoading) {
//                             return ListView.separated(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: 4,
//                               separatorBuilder:
//                                   (_, __) => const SizedBox(width: 16),
//                               itemBuilder:
//                                   (_, __) =>
//                                       const ShimmerBox(height: 160, width: 130),
//                             );
//                           }

//                           if (playlistVM.error != null) {
//                             return const Text(
//                               'Failed to load playlists',
//                               style: TextStyle(color: Colors.red),
//                             );
//                           }

//                           if (playlistVM.playlists.isEmpty) {
//                             return const Text(
//                               'No tracks found',
//                               style: TextStyle(color: Colors.white),
//                             );
//                           }

//                           return ListView.separated(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: playlistVM.playlists.length,
//                             separatorBuilder:
//                                 (_, __) => const SizedBox(width: 16),
//                             itemBuilder: (context, index) {
//                               final playlist = playlistVM.playlists[index];
//                               return PlaylistCard(playlist: playlist);
//                             },
//                           );
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     Text(
//                       kRecentlyPlayed,
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     const SizedBox(height: 12),

//                     Consumer<SongViewModel>(
//                       builder: (context, trackVM, _) {
//                         if (trackVM.isLoading) {
//                           return Column(
//                             children: List.generate(
//                               5,
//                               (index) => const Padding(
//                                 padding: EdgeInsets.only(bottom: 16),
//                                 child: ShimmerBox(
//                                   height: 64,
//                                   width: double.infinity,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }

//                         final filteredSongs =
//                             _searchQueryNotifier.value.isEmpty
//                                 ? trackVM.songs
//                                 : trackVM.songs.where((track) {
//                                   final name = track.name.toLowerCase();
//                                   final artist =
//                                       track.artists.first.name.toLowerCase();
//                                   return name.contains(
//                                         _searchQueryNotifier.value,
//                                       ) ||
//                                       artist.contains(
//                                         _searchQueryNotifier.value,
//                                       );
//                                 }).toList();

//                         if (filteredSongs.isEmpty) {
//                           return const Text(
//                             "No songs found",
//                             style: TextStyle(color: Colors.white70),
//                           );
//                         }

//                         return ListView.builder(
//                           controller: _scrollController,
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: filteredSongs.length,
//                           itemBuilder:
//                               (context, index) =>
//                                   SongTile(song: filteredSongs[index]),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchQueryNotifier.dispose();
//     super.dispose();
//   }
// }
