import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_event.dart';
import 'package:flutter_music_player/core/const/colors.dart';
import 'package:flutter_music_player/core/const/textstyles.dart';
import 'package:flutter_music_player/domain/models/audio_player_model.dart';

class AuditoTrackWidget extends StatelessWidget {
  final AudioPlayerModel audioPlayerModel;
  const AuditoTrackWidget({super.key, required this.audioPlayerModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: bgColor,
        title: Text(
          audioPlayerModel.audio.metas.title.toString(),
          style: customTextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          audioPlayerModel.audio.metas.artist.toString(),
          style: customTextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        leading: setLeading(),
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
          icon: setIcon(),
        ),
      ),
    );
  }

  Widget setLeading() {
    AssetImage assetImage =
        AssetImage(audioPlayerModel.audio.metas.image!.path);
    return Image(
      image: assetImage,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.music_note,
          color: whiteColor,
          size: 32,
        );
      },
    );
  }

  Widget setIcon() {
    if (audioPlayerModel.isPlaying) {
      return const Icon(
        Icons.pause,
        color: whiteColor,
        size: 26,
      );
    } else {
      return const Icon(
        Icons.play_arrow,
        color: whiteColor,
        size: 26,
      );
    }
  }
}
