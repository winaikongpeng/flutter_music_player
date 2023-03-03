import 'package:flutter_music_player/domain/models/audio_player_model.dart';
import 'audio_player_repository.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  final List<AudioPlayerModel> audioPlayerModels;

  AudioPlayerRepositoryImpl({required this.audioPlayerModels});

  @override
  Future<AudioPlayerModel> getById(String audioPlayerId) {
    return Future.value(
        audioPlayerModels.firstWhere((model) => model.id == audioPlayerId));
  }

  @override
  Future<List<AudioPlayerModel>> getAll() async {
    return Future.value(audioPlayerModels);
  }

  @override
  Future<List<AudioPlayerModel>> updateModel(AudioPlayerModel updatedModel) {
    audioPlayerModels[audioPlayerModels
        .indexWhere((element) => element.id == updatedModel.id)] = updatedModel;
    return Future.value(audioPlayerModels);
  }

  @override
  Future<List<AudioPlayerModel>> updateAllModels(
      List<AudioPlayerModel> updatedList) {
    audioPlayerModels.clear();
    audioPlayerModels.addAll(updatedList);
    return Future.value(audioPlayerModels);
  }
}
