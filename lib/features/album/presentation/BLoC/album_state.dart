part of 'album_bloc.dart';

@freezed
class AlbumState with _$AlbumState {
  const factory AlbumState.initial() = _Initial;
  const factory AlbumState.loading() = _Loading;
  const factory AlbumState.loaded({required List<Album> albums}) = _Loaded;
  const factory AlbumState.error({required String message}) = _Error;
}