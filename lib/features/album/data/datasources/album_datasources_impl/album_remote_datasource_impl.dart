import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/album_model.dart';
import '../../models/photo_model.dart';
import '../album_datasources/album_remote_datasource.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;
  final String _baseUrl = "https://jsonplaceholder.typicode.com";

  RemoteDataSourceImpl(this.dio);

  @override
  Future<List<AlbumModel>> getAlbums() async {
    try {
      final response = await dio.get('$_baseUrl/albums');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => AlbumModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PhotoModel>> getPhotosForAlbum(int albumId) async {
    try {
      final response = await dio.get('$_baseUrl/photos?albumId=$albumId');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => PhotoModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}