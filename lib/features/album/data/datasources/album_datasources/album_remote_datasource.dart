import '../../models/album_model.dart';
import '../../models/photo_model.dart';

abstract class RemoteDataSource {
  Future<List<AlbumModel>> getAlbums();
  Future<List<PhotoModel>> getPhotosForAlbum(int albumId);
}