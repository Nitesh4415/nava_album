import 'package:flutter/material.dart';
import '../../../../../core/utils/image_helper.dart';
import '../../../domain/entities/photo.dart';

class FullScreenPhotoViewer extends StatelessWidget {
  final List<Photo> photos;
  final int initialIndex;

  const FullScreenPhotoViewer({
    super.key,
    required this.photos,
    required this.initialIndex,
  });

  // The _getFallbackUrl function has been removed from here.

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: initialIndex);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final photo = photos[index];
          return InteractiveViewer(
            panEnabled: true,
            minScale: 1.0,
            maxScale: 4.0,
            child: Center(
              child: Image.network(
                photo.url, // Use the full-resolution URL
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.white,
                    ),
                  );
                },
                // Add the fallback logic here
                errorBuilder: (context, error, stackTrace) {
                  // If the original image fails, attempt to load the fallback.
                  return Image.network(
                    // Use the utility class method
                    ImageHelper.getFallbackUrl(photo.url, defaultSize: '600'),
                    fit: BoxFit.contain,
                    // Add a final error builder for the fallback itself.
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 80, color: Colors.grey);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
