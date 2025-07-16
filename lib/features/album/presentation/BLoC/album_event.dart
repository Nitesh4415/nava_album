part of 'album_bloc.dart';

@freezed
class AlbumEvent with _$AlbumEvent {
  const factory AlbumEvent.fetchAlbums() = FetchAlbums;
}