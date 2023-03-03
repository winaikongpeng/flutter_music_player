import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_music_player/domain/models/audio_player_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should instance object assert model copyWith', () async {
    //arrange
    final tModel =
        AudioPlayerModel(id: '1', isPlaying: false, audio: Audio(''));
    //act
    final result = tModel.copyWith();
    //assert
    expect(result, tModel);
  });
}
