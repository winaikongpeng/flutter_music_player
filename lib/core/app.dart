import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_bloc.dart';
import 'package:flutter_music_player/application/presentation/music_screen.dart';
import 'package:flutter_music_player/core/const/colors.dart';
import 'package:flutter_music_player/data/data_provider.dart';
import 'package:flutter_music_player/domain/repositories/audio_player_repository.dart';
import 'package:flutter_music_player/domain/repositories/audio_player_repository_impl.dart';
import 'widgets/custom_widgets.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AudioPlayerRepository>(
          create: (context) => AudioPlayerRepositoryImpl(
              audioPlayerModels: DataProvider.getAudioPlayerModels()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AudioPlayerBloc>(
            create: (BuildContext context) => AudioPlayerBloc(
              AssetsAudioPlayer.newPlayer(),
              RepositoryProvider.of<AudioPlayerRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter music player',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          home: const MainScreen(),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: customAppBar(),
      body: const MusicScreen(),
    );
  }
}
