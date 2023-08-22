import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/models.dart/character_model.dart';
import 'package:rick_and_morty_app/models.dart/episode_model.dart';
import 'package:rick_and_morty_app/services/services.dart';

class EpisodeInformationController with ChangeNotifier, DiagnosticableTreeMixin {
  EpisodeModel? episode;
  List<CharacterModel>? characters;

  updateEpisode(EpisodeModel episode) {
    this.episode = episode;
    notifyListeners();
  }

  Future<List<CharacterModel>> consultCharacters() async {
    characters = [];
    characters = await Services().getCharacters(episode!.characters!);
    return characters!;
  }
}
