import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'core/di/injectable.dart';
import 'features/album/data/models/album_model.dart';
import 'features/album/data/models/photo_model.dart';
import 'features/album/presentation/screens/album_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(AlbumModelAdapter());
  Hive.registerAdapter(PhotoModelAdapter());
  await Hive.openBox<AlbumModel>('albums');

  // Configure Dependency Injection
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Albums',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AlbumScreen(),
    );
  }
}