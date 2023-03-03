import 'package:flutter_bloc/flutter_bloc.dart';
import 'audio_player_event.dart';
import 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc() : super(AudioPlayerInitial()) {
    on<AudioPlayerEvent>((event, emit) {});
  }
}
