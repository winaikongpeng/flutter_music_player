import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_event.dart';
import 'package:flutter_music_player/application/bloc/audio_player_state.dart';
import 'package:flutter_music_player/core/widgets/custom_widgets.dart';
import 'package:flutter_music_player/domain/models/audio_player_model.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        if (state is AudioPlayerInitial || state is AudioPlayerReady) {
          return const SizedBox.shrink();
        }
        if (state is AudioPlayerPlaying) {
          return _showPlayer(context, state.playingAudio);
        }
        if (state is AudioPlayerPaused) {
          return _showPlayer(context, state.pausedAudio);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _showPlayer(BuildContext context, AudioPlayerModel model) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            color: Colors.grey.shade700,
            child: ListTile(
              leading: setLeading(model.audio.metas.image!.path),
              title: setTitle(model.audio.metas.title.toString()),
              subtitle: setSubtitle(model.audio.metas.artist.toString()),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              trailing: InkWell(
                child: setIcon(model.isPlaying),
                onTap: () {
                  if (model.isPlaying) {
                    context
                        .read<AudioPlayerBloc>()
                        .add(PressedPlayAudio(model));
                  } else {
                    context
                        .read<AudioPlayerBloc>()
                        .add(PressedPlayAudio(model));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
