import 'package:flutter_music_player/domain/models/audio_player_model.dart';

abstract class AudioPlayerRepository {
  Future<AudioPlayerModel> getById(String audioPlayerId);
  Future<List<AudioPlayerModel>> getAll();

  Future<List<AudioPlayerModel>> updateModel(AudioPlayerModel updatedModel);
  Future<List<AudioPlayerModel>> updateAllModels(
      List<AudioPlayerModel> updatedList);
}
