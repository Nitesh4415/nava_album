import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/repositories/album_repository.dart';
import '../datasources/album_datasources/album_local_datasource.dart';
import '../datasources/album_datasources/album_remote_datasource.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AlbumRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Album>>> getAlbumsWithPhotos() async {
    try {
      // First, try to get from cache
      final localAlbums = await localDataSource.getCachedAlbums();
      // Immediately return cached data if available
      return Right(localAlbums.map((model) => model.toEntity()).toList());
    } on CacheException {
      // If cache is empty, fetch from network
      try {
        final remoteAlbums = await remoteDataSource.getAlbums();

        // Fetch photos for each album
        final albumsWithPhotos = await Future.wait(remoteAlbums.map((album) async {
          final photos = await remoteDataSource.getPhotosForAlbum(album.id);
          return album.copyWith(photos: photos);
        }));

        // Cache the new data
        await localDataSource.cacheAlbums(albumsWithPhotos);

        return Right(albumsWithPhotos.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
