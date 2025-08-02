import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/pages/AlbumTracksScreen.dart';
import 'package:my_spotify/utils/Constants.dart';
import 'package:my_spotify/utils/GradientScaffold%20.dart';

class AllAlbumsScreen extends StatelessWidget {
  final List<AlbumModel> albums;
  final String artistName;

  const AllAlbumsScreen({
    Key? key,
    required this.albums,
    required this.artistName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '$artistName\'s Albums',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          itemCount: albums.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            final album = albums[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AlbumTracksScreen(album: album),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(album.imageUrl, fit: BoxFit.cover),
                    ),
                    // Overlay gelap (transparan)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(
                          0.4,
                        ), // ubah opacity sesuai kebutuhan
                      ),
                    ),
                    Center(
                      child: Text(
                        album.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: const Color.fromARGB(255, 99, 99, 99),
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
