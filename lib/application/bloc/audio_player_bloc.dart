import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc() : super(AudioPlayerInitial()) {
    on<AudioPlayerEvent>((event, emit) {});
  }
}
