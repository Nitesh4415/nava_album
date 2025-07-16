import 'package:hive/hive.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/album_model.dart';
import '../album_datasources/album_local_datasource.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final Box<AlbumModel> albumBox;

  LocalDataSourceImpl(this.albumBox);

  @override
  Future<void> cacheAlbums(List<AlbumModel> albums) async {
    await albumBox.clear();
    for (var album in albums) {
      await albumBox.put(album.id, album);
    }
  }

  @override
  Future<List<AlbumModel>> getCachedAlbums() async {
    final albums = albumBox.values.toList();
    if (albums.isNotEmpty) {
      return albums;
    } else {
      throw CacheException();
    }
  }
}
