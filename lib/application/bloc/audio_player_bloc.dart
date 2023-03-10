import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/domain/models/audio_player_model.dart';
import 'package:flutter_music_player/domain/repositories/audio_player_repository.dart';
import 'audio_player_event.dart';
import 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AssetsAudioPlayer assetsAudioPlayer;
  final AudioPlayerRepository audioPlayerRepository;
  List<StreamSubscription> playerSubscriptions = [];

  AudioPlayerBloc(
    this.assetsAudioPlayer,
    this.audioPlayerRepository,
  ) : super(AudioPlayerInitial()) {
    playerSubscriptions.add(assetsAudioPlayer.playerState.listen((event) {
      _mapPlayerStateToEvent(event);
    }));

    on<AudioPlayerEvent>(_onAudioEvent);

    on<AudioPlayed>(_mapAudioPlayedToState);

    on<AudioPaused>(_mapAudioPausedToState);

    on<AudioStopped>(_mapAudioStoppedToState);

    on<PressedPlayAudio>(_mapPressedPlayAudio);

    on<PressedPauseAudio>(_mapPressedPauseAudio);
  }

  FutureOr<void> _onAudioEvent(
      AudioPlayerEvent event, Emitter<AudioPlayerState> emit) async {
    if (event is InitialAudio) {
      _initState(emit, event);
    }
  }

  FutureOr<void> _initState(
      Emitter<AudioPlayerState> emit, InitialAudio event) async {
    final audioList = await audioPlayerRepository.getAll();
    emit(AudioPlayerReady(audioList));
  }

  @override
  Future<void> close() {
    super.close();
    for (var element in playerSubscriptions) {
      element.cancel();
    }
    return assetsAudioPlayer.dispose();
  }

  FutureOr<void> _mapPlayerStateToEvent(PlayerState playerState) {
    if (playerState == PlayerState.stop) {
      add(const AudioStopped());
    } else if (playerState == PlayerState.pause) {
      add(AudioPaused(assetsAudioPlayer.current.value!.audio.audio.metas.id!));
    } else if (playerState == PlayerState.play) {
      add(AudioPlayed(assetsAudioPlayer.current.value!.audio.audio.metas.id!));
    }
  }

  FutureOr<void> _mapAudioPlayedToState(
    AudioPlayed event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final List<AudioPlayerModel> currentList =
        await audioPlayerRepository.getAll();
    final List<AudioPlayerModel> updatedList = currentList
        .map((audioModel) => audioModel.audio.metas.id == event.audioModelMetaId
            ? audioModel.copyWith(isPlaying: true)
            : audioModel.copyWith(isPlaying: false))
        .toList();
    await audioPlayerRepository.updateAllModels(updatedList);

    final AudioPlayerModel currentlyPlaying = updatedList
        .firstWhere((model) => model.audio.metas.id == event.audioModelMetaId);
    emit(AudioPlayerPlaying(currentlyPlaying, updatedList));
  }

  FutureOr<void> _mapAudioPausedToState(
    AudioPaused event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final List<AudioPlayerModel> currentList =
        await audioPlayerRepository.getAll();

    final List<AudioPlayerModel> updatedList = currentList
        .map((audioModel) => audioModel.audio.metas.id == event.audioModelMetaId
            ? audioModel.copyWith(isPlaying: false)
            : audioModel)
        .toList();
    await audioPlayerRepository.updateAllModels(updatedList);
    final AudioPlayerModel currentlyPaused = currentList
        .firstWhere((model) => model.audio.metas.id == event.audioModelMetaId);
    emit(AudioPlayerPaused(currentlyPaused, updatedList));
  }

  FutureOr<void> _mapAudioStoppedToState(
    AudioStopped event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final List<AudioPlayerModel> currentList =
        await audioPlayerRepository.getAll();

    final List<AudioPlayerModel> updatedList = currentList
        .map((audioModel) => audioModel.isPlaying
            ? audioModel.copyWith(isPlaying: false)
            : audioModel)
        .toList();

    audioPlayerRepository.updateAllModels(updatedList);

    emit(AudioPlayerReady(updatedList));
  }

  FutureOr<void> _mapPressedPlayAudio(
    PressedPlayAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    //condition 1
    if (state is AudioPlayerReady) {
      //logic
      final AudioPlayerModel updatedModel =
          event.audioPlayerModel.copyWith(isPlaying: true);
      final updatedList = await audioPlayerRepository.updateModel(updatedModel);
      await assetsAudioPlayer.open(updatedModel.audio, showNotification: true);
      emit(AudioPlayerPlaying(updatedModel, updatedList));
    }
    //condition 2
    if (state is AudioPlayerPaused) {
      //logic
      if (event.audioPlayerModel.id ==
          (state as AudioPlayerPaused).pausedAudio.id) {
        final AudioPlayerModel updatedModel =
            event.audioPlayerModel.copyWith(isPlaying: true);
        final updatedList =
            await audioPlayerRepository.updateModel(updatedModel);
        await assetsAudioPlayer.play();
        emit(AudioPlayerPlaying(updatedModel, updatedList));
      } else {
        final AudioPlayerModel updatedModel =
            event.audioPlayerModel.copyWith(isPlaying: true);
        final updatedList =
            await audioPlayerRepository.updateModel(updatedModel);

        await assetsAudioPlayer.open(updatedModel.audio,
            showNotification: true,
            respectSilentMode: true,
            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug);

        emit(AudioPlayerPlaying(updatedModel, updatedList));
      }
    }
    //condition 3
    if (state is AudioPlayerPlaying) {
      //logic
      final AudioPlayerModel updatedModel =
          event.audioPlayerModel.copyWith(isPlaying: true);
      final updatedList = await audioPlayerRepository.updateModel(updatedModel);

      await assetsAudioPlayer.open(updatedModel.audio, showNotification: true);

      emit(AudioPlayerPlaying(updatedModel, updatedList));
    }
  }

  FutureOr<void> _mapPressedPauseAudio(
    PressedPauseAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    //logic
    final AudioPlayerModel updatedModel =
        event.audioPlayerModel.copyWith(isPlaying: false);
    final updatedList = await audioPlayerRepository.updateModel(updatedModel);

    await assetsAudioPlayer.pause();
    emit(AudioPlayerPaused(updatedModel, updatedList));
  }
}
