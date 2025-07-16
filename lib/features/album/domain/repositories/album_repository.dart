import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/album.dart';

abstract class AlbumRepository {
  Future<Either<Failure, List<Album>>> getAlbumsWithPhotos();
}