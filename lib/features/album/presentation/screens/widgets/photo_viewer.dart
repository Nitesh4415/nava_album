import 'package:flutter/material.dart';
import '../../../../../core/utils/image_helper.dart';
import '../../../domain/entities/photo.dart';
import 'fullscreen_photo_viewer.dart';

class PhotoViewer extends StatefulWidget {
  final List<Photo> photos;
  const PhotoViewer({super.key, required this.photos});

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Start in the middle for infinite scrolling effect
    _pageController = PageController(
      initialPage: 10000,
      viewportFraction: 0.4, // Show adjacent images
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // The _getFallbackUrl function has been removed from here.

  @override
  Widget build(BuildContext context) {
    if (widget.photos.isEmpty) {
      return const Center(child: Text('No photos in this album.'));
    }
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        final realIndex = index % widget.photos.length;
        final photo = widget.photos[realIndex];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenPhotoViewer(
                  photos: widget.photos,
                  initialIndex: realIndex,
                ),
              ),
            );
          },
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  photo.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      // Use the utility class method
                      ImageHelper.getFallbackUrl(photo.thumbnailUrl, defaultSize: '150'),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
                      },
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(4.0),
                    color: Colors.black.withAlpha(128),
                    child: Text(
                      'Img #${photo.id}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}