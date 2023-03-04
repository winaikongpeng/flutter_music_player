import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_music_player/domain/models/audio_player_model.dart';

class DataProvider {
  static String pathAudio(String fileName) => 'assets/audios/$fileName';
  static String pathImage(String fileName) => 'assets/images/$fileName';

  static List<AudioPlayerModel> getAudioPlayerModels() => [
        AudioPlayerModel(
          id: '1',
          isPlaying: false,
          audio: Audio(
            pathAudio('Joji - Sanctuary (Official Video).mp3'),
            metas: Metas(
              id: '1',
              title: 'Sanctuary',
              artist: 'Joji',
              album: 'Nectar',
              image: MetasImage.asset(pathImage('joji-image.png')),
            ),
          ),
        ),
        AudioPlayerModel(
          id: '2',
          isPlaying: false,
          audio: Audio(
            pathAudio('sapientdream - Pastlives (lyrics).mp3'),
            metas: Metas(
              id: '2',
              title: 'Pastlives (lyrics)',
              artist: 'sapientdream',
              album: 'Holde Me',
              image: MetasImage.asset(pathImage('pastlive-image.png')),
            ),
          ),
        ),
      ];
}
