import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/album.dart';
import 'photo_model.dart';

part 'album_model.freezed.dart';
part 'album_model.g.dart';

@freezed
@HiveType(typeId: 0)
class AlbumModel with _$AlbumModel {
  const AlbumModel._();

  const factory AlbumModel({
    @HiveField(0) required int userId,
    @HiveField(1) required int id,
    @HiveField(2) required String title,
    @HiveField(3) List<PhotoModel>? photos,
  }) = _AlbumModel;

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

  Album toEntity() => Album(
    userId: userId,
    id: id,
    title: title,
    photos: photos?.map((p) => p.toEntity()).toList() ?? [],
  );
}