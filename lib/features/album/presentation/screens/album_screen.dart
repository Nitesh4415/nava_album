import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injectable.dart';
import '../../domain/usecase/get_album_usecase.dart';
import '../bloc/album_bloc.dart';
import 'widgets/album_card.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late final ScrollController _verticalScrollController;
  late final AlbumBloc _albumBloc;

  @override
  void initState() {
    super.initState();
    // Start in the "middle" of the list to allow scrolling up/down
    _verticalScrollController = ScrollController(initialScrollOffset: 10000.0);

    // Manually create the BLoC instance, getting its dependency from GetIt
    _albumBloc = AlbumBloc(getIt<GetAlbumsUseCase>())
      ..add(const AlbumEvent.fetchAlbums());
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _albumBloc.close(); // It's important to close the BLoC
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use BlocProvider.value to provide the existing BLoC instance
    return BlocProvider.value(
      value: _albumBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Photo Albums'),
          backgroundColor: Colors.deepPurple.shade100,
        ),
        body: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('Initializing...')),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text(message)),
              loaded: (albums) {
                if (albums.isEmpty) {
                  return const Center(child: Text('No albums found.'));
                }
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    controller: _verticalScrollController,
                    itemBuilder: (context, index) {
                      final album = albums[index % albums.length];
                      return AlbumCard(album: album, albumNumber: index + 1);
                    },
                    // Use a large number for infinite looping effect
                    itemCount: 100000,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
