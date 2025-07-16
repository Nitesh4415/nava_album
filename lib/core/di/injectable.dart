import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../features/album/data/datasources/album_datasources/album_local_datasource.dart';
import '../../features/album/data/datasources/album_datasources/album_remote_datasource.dart';
import '../../features/album/data/datasources/album_datasources_impl/album_local_datasource_impl.dart';
import '../../features/album/data/datasources/album_datasources_impl/album_remote_datasource_impl.dart';
import '../../features/album/data/models/album_model.dart';
import '../../features/album/data/repositories/album_repository_impl.dart';
import '../../features/album/domain/repositories/album_repository.dart';
import '../../features/album/domain/usecase/get_album_usecase.dart';
import '../../features/album/presentation/BLoC/album_bloc.dart';


final getIt = GetIt.instance;

// Manual Dependency Injection Setup
Future<void> configureDependencies() async {

  // BLoC - registerFactory creates a new instance every time it's requested.
  getIt.registerFactory(() => AlbumBloc(getIt()));

  // Use Cases - registerLazySingleton creates one instance when it's first requested.
  getIt.registerLazySingleton(() => GetAlbumsUseCase(getIt()));

  // Repositories
  getIt.registerLazySingleton<AlbumRepository>(() => AlbumRepositoryImpl(
    remoteDataSource: getIt(),
    localDataSource: getIt(),
  ));

  // Data Sources
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(getIt()));

  // External Dependencies
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton<Box<AlbumModel>>(() => Hive.box<AlbumModel>('albums'));
}
