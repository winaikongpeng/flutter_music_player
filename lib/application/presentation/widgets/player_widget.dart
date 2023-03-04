import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_event.dart';
import 'package:flutter_music_player/application/bloc/audio_player_state.dart';
import 'package:flutter_music_player/core/const/colors.dart';
import 'package:flutter_music_player/core/widgets/custom_widgets.dart';
import 'package:flutter_music_player/domain/models/audio_player_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        if (state is AudioPlayerInitial || state is AudioPlayerReady) {
          return const SizedBox.shrink();
        }
        if (state is AudioPlayerPlaying) {
          return _showPlayer(context, state.playingAudio, true);
        }
        if (state is AudioPlayerPaused) {
          return _showPlayer(context, state.pausedAudio, false);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _showPlayer(
      BuildContext context, AudioPlayerModel model, bool showAnimation) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            color: Colors.grey.shade700,
            child: ListTile(
                leading:
                    setLeading(model.audio.metas.image!.path, showAnimation),
                title: setTitle(model.audio.metas.title.toString()),
                subtitle: setSubtitle(model.audio.metas.artist.toString()),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                trailing: setTrailing(model, context, showAnimation)),
          ),
        ],
      ),
    );
  }

  Widget setLeading(String path, bool showAnimation) {
    try {
      AssetImage assetImage = AssetImage(path);

      if (showAnimation) {
        return RotationTransition(
            turns: animation,
            child: CircleAvatar(radius: 30, backgroundImage: assetImage));
      } else {
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
    } catch (e) {
      return const Icon(
        Icons.music_note,
        color: whiteColor,
        size: 32,
      );
    }
  }

  Widget setTrailing(
      AudioPlayerModel model, BuildContext context, bool showAnimation) {
    if (showAnimation) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SpinKitWave(
              size: 26, color: buttonColor, type: SpinKitWaveType.start),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: setIcon(model.isPlaying),
            onPressed: () {
              if (model.isPlaying) {
                BlocProvider.of<AudioPlayerBloc>(context)
                    .add(PressedPauseAudio(model));
              } else {
                BlocProvider.of<AudioPlayerBloc>(context)
                    .add(PressedPlayAudio(model));
              }
            },
          ),
        ],
      );
    } else {
      return IconButton(
        icon: setIcon(model.isPlaying),
        onPressed: () {
          if (model.isPlaying) {
            BlocProvider.of<AudioPlayerBloc>(context)
                .add(PressedPauseAudio(model));
          } else {
            BlocProvider.of<AudioPlayerBloc>(context)
                .add(PressedPlayAudio(model));
          }
        },
      );
    }
  }
}
