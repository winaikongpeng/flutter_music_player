import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_bloc.dart';
import 'package:flutter_music_player/application/bloc/audio_player_state.dart';
import 'package:flutter_music_player/core/widgets/custom_widgets.dart';
import 'widgets/audio_track_widget.dart';
import 'widgets/player_widget.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     padding: EdgeInsets.zero,
    //     physics: const BouncingScrollPhysics(),
    //     itemCount: 10,
    //     itemBuilder: (ctx, index) {
    //       String musicName = 'musicName';
    //       String artistName = 'artistName';

    //       return Container(
    //         margin: const EdgeInsets.only(bottom: 5),
    //         child: ListTile(
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(15)),
    //           tileColor: bgColor,
    //           title: Text(
    //             musicName,
    //             style:
    //                 customTextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    //           ),
    //           subtitle: Text(
    //             artistName,
    //             style: customTextStyle(
    //                 fontSize: 12, fontWeight: FontWeight.normal),
    //           ),
    //           leading: const Icon(
    //             Icons.music_note,
    //             color: whiteColor,
    //             size: 32,
    //           ),
    //           trailing: const Icon(
    //             Icons.play_arrow,
    //             color: whiteColor,
    //             size: 26,
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );

    return Container(
      alignment: Alignment.center,
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          if (state is AudioPlayerInitial) {
            return loadingWidget();
          } else if (state is AudioPlayerReady) {
            return buildReadyTrackList(state);
          } else if (state is AudioPlayerPlaying) {
            return buildPlayingTrackList(state);
          } else if (state is AudioPlayerPaused) {
            return buildPausedTrackList(state);
          } else {
            return errorText('Something went wrong');
          }
        },
      ),
    );
  }

  Widget buildReadyTrackList(AudioPlayerReady state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: state.listAudios.length,
        itemBuilder: (BuildContext context, int index) {
          return AudioTrackWidget(audioPlayerModel: state.listAudios[index]);
        },
      ),
    );
  }

  Widget buildPlayingTrackList(AudioPlayerPlaying state) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              // padding: const EdgeInsets.only(bottom: 100),
              itemCount: state.listAudios.length,
              itemBuilder: (BuildContext context, int index) {
                return AudioTrackWidget(
                    audioPlayerModel: state.listAudios[index]);
              },
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: const PlayerWidget(),
        )
      ],
    );
  }

  Widget buildPausedTrackList(AudioPlayerPaused state) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              // padding:const  EdgeInsets.only(bottom: 100),
              itemCount: state.listAudios.length,
              itemBuilder: (BuildContext context, int index) {
                return AudioTrackWidget(
                    audioPlayerModel: state.listAudios[index]);
              },
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: const PlayerWidget(),
        )
      ],
    );
  }
}
