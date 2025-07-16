import '../../models/album_model.dart';

abstract class LocalDataSource {
  Future<List<AlbumModel>> getCachedAlbums();
  Future<void> cacheAlbums(List<AlbumModel> albums);
}