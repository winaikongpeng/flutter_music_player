import 'package:equatable/equatable.dart';
import 'package:flutter_music_player/domain/models/audio_player_model.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();
}

class InitialAudio extends AudioPlayerEvent {
  const InitialAudio();

  @override
  List<Object> get props => [];
}

class PressedPlayAudio extends AudioPlayerEvent {
  final AudioPlayerModel audioPlayerModel;
  const PressedPlayAudio(this.audioPlayerModel);

  @override
  List<Object> get props => [audioPlayerModel];
}

class PressedPauseAudio extends AudioPlayerEvent {
  final AudioPlayerModel audioPlayerModel;
  const PressedPauseAudio(this.audioPlayerModel);

  @override
  List<Object> get props => [audioPlayerModel];
}

class AudioPlayed extends AudioPlayerEvent {
  final String audioModelMetaId;
  const AudioPlayed(this.audioModelMetaId);

  @override
  List<Object> get props => [audioModelMetaId];
}

class AudioPaused extends AudioPlayerEvent {
  final String audioModelMetaId;
  const AudioPaused(this.audioModelMetaId);

  @override
  List<Object> get props => [audioModelMetaId];
}

class AudioStopped extends AudioPlayerEvent {
  const AudioStopped();

  @override
  List<Object> get props => [];
}
