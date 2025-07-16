import 'package:flutter/material.dart';
import '../../../../../core/l10n/app_localizations.dart';
import '../../../domain/entities/album.dart';
import 'photo_viewer.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  final int albumNumber; // Add albumNumber field

  const AlbumCard({
    super.key,
    required this.album,
    required this.albumNumber, // Make it required in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              // Prepend the album number to the title
              '$albumNumber. ${AppLocalizations.of(context)?.translate(album.title) ?? album.title}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 150, child: PhotoViewer(photos: album.photos)),
          const Divider(height: 24, thickness: 1),
        ],
      ),
    );
  }
}
