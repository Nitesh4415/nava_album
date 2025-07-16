import 'package:equatable/equatable.dart';
import 'photo.dart';

class Album extends Equatable {
  final int userId;
  final int id;
  final String title;
  final List<Photo> photos;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
    required this.photos,
  });

  @override
  List<Object?> get props => [userId, id, title, photos];
}