import 'package:get_it/get_it.dart';
import 'package:my_spotify/repositories/AlbumRepository.dart';
import 'package:my_spotify/repositories/ArtistRepository.dart';
import 'package:my_spotify/repositories/PlaylistRepository.dart';
import 'package:my_spotify/repositories/SongRepository.dart';
import 'package:my_spotify/services/ApiService.dart';
import 'package:my_spotify/viewmodels/AlbumViewModel.dart';
import 'package:my_spotify/viewmodels/ArtistViewModel.dart';
import 'package:my_spotify/viewmodels/PlaylistViewModel.dart';
import 'package:my_spotify/viewmodels/SongViewModel.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton<ApiService>(() => ApiService());

  // Repositories
  locator.registerLazySingleton(() => AlbumRepository(locator()));
  locator.registerLazySingleton(() => ArtistRepository(locator()));
  locator.registerLazySingleton(() => PlaylistRepository(locator()));
  locator.registerLazySingleton(() => SongRepository(locator()));

  // ViewModels (gunakan registerFactory agar fresh setiap kali di-request)
  locator.registerLazySingleton(() => AlbumViewModel(locator()));
  locator.registerLazySingleton(() => ArtistViewModel(locator()));
  locator.registerLazySingleton(() => PlaylistViewModel(locator()));
  locator.registerLazySingleton(() => SongViewModel(locator()));
}
