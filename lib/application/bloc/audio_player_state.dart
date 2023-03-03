import 'package:equatable/equatable.dart';
import 'package:flutter_music_player/domain/models/audio_player_model.dart';

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();
}

class AudioPlayerInitial extends AudioPlayerState {
  @override
  List<Object?> get props => [];
}

class AudioPlayerReady extends AudioPlayerState {
  final List<AudioPlayerModel> listAudios;
  const AudioPlayerReady(this.listAudios);

  @override
  List<Object> get props => [listAudios];
}

class AudioPlayerPlaying extends AudioPlayerState {
  final List<AudioPlayerModel> listAudios;
  final AudioPlayerModel playingAudio;
  const AudioPlayerPlaying(this.playingAudio, this.listAudios);

  @override
  List<Object> get props => [playingAudio, listAudios];
}

class AudioPlayerPaused extends AudioPlayerState {
  final List<AudioPlayerModel> listAudios;
  final AudioPlayerModel pausedAudio;
  const AudioPlayerPaused(this.pausedAudio, this.listAudios);

  @override
  List<Object> get props => [pausedAudio];
}

class AudioPlayerFailure extends AudioPlayerState {
  final String error;
  const AudioPlayerFailure(this.error);

  @override
  List<Object> get props => [error];
}
