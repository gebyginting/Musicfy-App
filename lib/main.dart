import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/pages/HomeScreen.dart';
import 'package:my_spotify/repositories/AlbumRepository.dart';
import 'package:my_spotify/repositories/ArtistRepository.dart';
import 'package:my_spotify/repositories/PlaylistRepository.dart';
import 'package:my_spotify/repositories/SongRepository.dart';
import 'package:my_spotify/viewmodels/AlbumViewModel.dart';
import 'package:my_spotify/viewmodels/ArtistViewModel.dart';
import 'package:my_spotify/viewmodels/PlaylistViewModel.dart';
import 'package:my_spotify/viewmodels/SongViewModel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inisialisasi Hive
  await Hive.initFlutter();

  // register adapter
  Hive.registerAdapter(TrackModelAdapter());

  // buka box
  await Hive.openBox<TrackModel>('favorites');

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => Songrepository()),
        Provider(create: (_) => Playlistrepository()),
        Provider(create: (_) => ArtistRepository()),
        Provider(create: (_) => AlbumRepository()),

        ChangeNotifierProvider(
          create: (context) => SongViewModel(context.read<Songrepository>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  Playlistviewmodel(context.read<Playlistrepository>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) => ArtistViewModel(context.read<ArtistRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => AlbumViewModel(context.read<AlbumRepository>()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}
