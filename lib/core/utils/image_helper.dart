class ImageHelper {
  /// Takes the [originalUrl] and an optional [defaultSize] for the generic fallback.
  static String getFallbackUrl(String originalUrl, {String defaultSize = '150'}) {
    if (originalUrl.startsWith('https://via.placeholder.com')) {
      final parts = originalUrl.split('/');
      if (parts.length >= 5) {
        final size = parts[3]; // e.g., "150" or "600"
        final color = parts[4];
        return 'https://dummyimage.com/$size/$color';
      }
    }
    // Return a generic fallback if the original URL format is unexpected.
    return 'https://dummyimage.com/$defaultSize/cccccc&text=Error';
  }
}