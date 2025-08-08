import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/pages/AlbumTracksScreen.dart';
import 'package:my_spotify/pages/ArtistScreen.dart';

class ConditionalMarqueeText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const ConditionalMarqueeText({super.key, required this.text, this.style});

  @override
  State<ConditionalMarqueeText> createState() => _ConditionalMarqueeTextState();
}

class _ConditionalMarqueeTextState extends State<ConditionalMarqueeText> {
  @override
  Widget build(BuildContext context) {
    final defaultStyle = widget.style ?? const TextStyle(fontSize: 16);

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text, style: defaultStyle),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(minWidth: 0, maxWidth: constraints.maxWidth);
        debugPrint(
          'Text width: ${textPainter.width}, Max width: ${constraints.maxWidth}',
        );

        final isOverflowing = textPainter.didExceedMaxLines;
        final textHeight =
            textPainter.height == 0
                ? defaultStyle.fontSize ?? 16
                : textPainter.height;

        if (isOverflowing) {
          return SizedBox(
            height: textHeight,
            width: double.infinity,
            child: ClipRect(
              child: Marquee(
                text: widget.text,
                style: defaultStyle,
                scrollAxis: Axis.horizontal,
                blankSpace: 20.0,
                velocity: 30.0,
                pauseAfterRound: const Duration(seconds: 2),
                startAfter: const Duration(seconds: 2),
                showFadingOnlyWhenScrolling: true,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
              ),
            ),
          );
        } else {
          return Text(
            widget.text,
            style: defaultStyle,
            maxLines: 1,
            overflow: TextOverflow.clip,
          );
        }
      },
    );
  }
}

// More Action For Track
void showTrackOptions({
  required BuildContext context,
  required TrackModel track,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.grey[900],
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text(
              'Lihat Artist',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              if (track.artists.length == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ArtistScreen(artistId: track.artists.first.id),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => SimpleDialog(
                        title: const Text('Pilih Artist'),
                        children:
                            track.artists.map((artist) {
                              return ListTile(
                                title: Text(artist.name),
                                onTap: () {
                                  Navigator.pop(ctx);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              ArtistScreen(artistId: artist.id),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                      ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.album, color: Colors.white),
            title: const Text(
              'Lihat Album',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              print('Album ID: ${track.albumId}');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AlbumTracksScreen(albumId: track.albumId),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share, color: Colors.white),
            title: const Text('Share', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement sharing
            },
          ),
        ],
      );
    },
  );
}
