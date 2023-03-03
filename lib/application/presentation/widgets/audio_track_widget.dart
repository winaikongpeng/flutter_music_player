import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_event.dart';
import 'package:flutter_music_player/core/const/colors.dart';
import 'package:flutter_music_player/core/widgets/custom_widgets.dart';
import 'package:flutter_music_player/domain/models/audio_player_model.dart';

class AudioTrackWidget extends StatelessWidget {
  final AudioPlayerModel audioPlayerModel;
  const AudioTrackWidget({super.key, required this.audioPlayerModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: bgColor,
        title: setTitle(audioPlayerModel.audio.metas.title.toString()),
        subtitle: setSubtitle(audioPlayerModel.audio.metas.artist.toString()),
        leading: setLeading(audioPlayerModel.audio.metas.image!.path),
        trailing: IconButton(
          onPressed: () {
            if (audioPlayerModel.isPlaying) {
              context
                  .read<AudioPlayerBloc>()
                  .add(PressedPauseAudio(audioPlayerModel));
            } else {
              context
                  .read<AudioPlayerBloc>()
                  .add(PressedPlayAudio(audioPlayerModel));
            }
          },
          icon: setIcon(audioPlayerModel.isPlaying),
        ),
      ),
    );
  }
}
