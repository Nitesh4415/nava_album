import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/album.dart';
import '../../domain/usecase/get_album_usecase.dart';

part 'album_bloc.freezed.dart';
part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbumsUseCase getAlbumsWithPhotos;

  AlbumBloc(this.getAlbumsWithPhotos) : super(const AlbumState.initial()) {
    on<FetchAlbums>((event, emit) async {
      emit(const AlbumState.loading());
      final failureOrAlbums = await getAlbumsWithPhotos();
      failureOrAlbums.fold(
            (failure) => emit(const AlbumState.error(message: 'Failed to fetch data')),
            (albums) => emit(AlbumState.loaded(albums: albums)),
      );
    });
  }
}
