import 'package:flutter/material.dart';
import 'package:my_spotify/models/track_model.dart';

class PlaylistModel {
  final String id;
  final String name;
  final String description;
  final String href;
  final List<ImageModel> images;
  final Owner owner;
  final Tracks tracks;

  PlaylistModel({
    required this.id,
    required this.name,
    required this.description,
    required this.href,
    required this.images,
    required this.owner,
    required this.tracks,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      href: json['href'] ?? '',
      images:
          (json['images'] as List? ?? [])
              .map((img) => ImageModel.fromJson(img))
              .toList(),
      owner: Owner.fromJson(json['owner'] ?? {}),
      tracks: Tracks.fromJson(json['tracks'] ?? {}),
    );
  }
}

class ImageModel {
  final String url;
  final int? height;
  final int? width;

  ImageModel({required this.url, this.height, this.width});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'] ?? '',
      height: json['height'],
      width: json['width'],
    );
  }
}

class Owner {
  final String displayName;
  final String id;

  Owner({required this.displayName, required this.id});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(displayName: json['display_name'] ?? '', id: json['id'] ?? '');
  }
}

class Tracks {
  final String href;
  final List<PlaylistItem> items;
  final int total;

  Tracks({required this.href, required this.items, required this.total});

  factory Tracks.fromJson(Map<String, dynamic> json) {
    return Tracks(
      href: json['href'] ?? '',
      total: json['total'] ?? 0,
      items:
          (json['items'] as List? ?? [])
              .map((item) {
                try {
                  return PlaylistItem.fromJson(item);
                } catch (e) {
                  debugPrint('Error parsing item: $e');
                  return null;
                }
              })
              .whereType<PlaylistItem>()
              .toList(),
    );
  }
}

class PlaylistItem {
  final String addedAt;
  final AddedBy addedBy;
  final TrackModel track;

  PlaylistItem({
    required this.addedAt,
    required this.addedBy,
    required this.track,
  });

  factory PlaylistItem.fromJson(Map<String, dynamic> json) {
    return PlaylistItem(
      addedAt: json['added_at'] ?? '',
      addedBy: AddedBy.fromJson(json['added_by'] ?? {}),
      track: TrackModel.fromJson(json['track'] ?? {}),
    );
  }
}

class AddedBy {
  final String id;

  AddedBy({required this.id});

  factory AddedBy.fromJson(Map<String, dynamic> json) {
    return AddedBy(id: json['id'] ?? '');
  }
}

// class Track {
//   final String id;
//   final String name;
//   final String href;
//   final Album album;
//   final List<Artist> artists;
//   final int durationMs;
//   final String? previewUrl;

//   Track({
//     required this.id,
//     required this.name,
//     required this.href,
//     required this.album,
//     required this.artists,
//     required this.durationMs,
//     this.previewUrl,
//   });

//   factory Track.fromJson(Map<String, dynamic> json) {
//     return Track(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       href: json['href'] ?? '',
//       previewUrl: json['preview_url'], // nullable
//       durationMs: json['duration_ms'] ?? 0,
//       album: Album.fromJson(json['album'] ?? {}),
//       artists:
//           (json['artists'] as List? ?? [])
//               .map((a) => Artist.fromJson(a))
//               .toList(),
//     );
//   }
// }

// class Album {
//   final String name;
//   final String href;
//   final List<ImageModel> images;

//   Album({required this.name, required this.href, required this.images});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       name: json['name'] ?? '',
//       href: json['href'] ?? '',
//       images:
//           (json['images'] as List? ?? [])
//               .map((img) => ImageModel.fromJson(img))
//               .toList(),
//     );
//   }
// }

// class Artist {
//   final String id;
//   final String name;

//   Artist({required this.id, required this.name});

//   factory Artist.fromJson(Map<String, dynamic> json) {
//     return Artist(id: json['id'] ?? '', name: json['name'] ?? '');
//   }
// }
