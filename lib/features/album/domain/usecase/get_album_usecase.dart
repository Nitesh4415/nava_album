import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/album.dart';
import '../repositories/album_repository.dart';

class GetAlbumsUseCase {
  final AlbumRepository repository;

  GetAlbumsUseCase(this.repository);

  Future<Either<Failure, List<Album>>> call() async {
    return await repository.getAlbumsWithPhotos();
  }
}