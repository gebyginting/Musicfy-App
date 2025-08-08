import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/pages/HomeScreen.dart';
import 'package:my_spotify/repositories/setup_locator.dart';
import 'package:my_spotify/viewmodels/AlbumViewModel.dart';
import 'package:my_spotify/viewmodels/ArtistViewModel.dart';
import 'package:my_spotify/viewmodels/PlaylistViewModel.dart';
import 'package:my_spotify/viewmodels/SongViewModel.dart';
import 'package:provider/provider.dart';

void main() async {
  // 1️⃣ Load .env
  try {
    await dotenv.load(fileName: ".env");

    debugPrint(".env loaded successfully");
  } catch (e) {
    debugPrint("Failed to load .env: $e");
  }

  // 2️⃣ Init Hive
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(TrackModelAdapter());
    Hive.registerAdapter(ArtistAdapter());
    await Hive.openBox<TrackModel>('favorites');
    debugPrint("Hive initialized successfully");
  } catch (e) {
    debugPrint("Hive initialization failed: $e");
  }

  // 3️⃣ Setup Dependency Injection
  try {
    setupLocator();
    debugPrint("Service locator setup completed");
  } catch (e) {
    debugPrint("Service locator setup failed: $e");
  }

  // 4️⃣ Styling System UI
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<SongViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<PlaylistViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ArtistViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<AlbumViewModel>()),
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
        textTheme: GoogleFonts.poppinsTextTheme(
          TextTheme(
            titleLarge: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            titleSmall: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            bodyMedium: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            bodySmall: TextStyle(fontSize: 12.0, color: Colors.white),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}
