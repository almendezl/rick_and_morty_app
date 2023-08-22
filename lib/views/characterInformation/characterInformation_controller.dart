import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models.dart/character_model.dart';
import 'package:rick_and_morty_app/models.dart/episode_model.dart';
import 'package:rick_and_morty_app/models.dart/location_model.dart';
import 'package:rick_and_morty_app/views/locationInformation/locationInformation_controller.dart';

import '../../services/services.dart';

class CharacterInformationController with ChangeNotifier, DiagnosticableTreeMixin {
  CharacterModel? character;
  List<EpisodeModel>? episodes;
  updateCharacter(CharacterModel character) {
    this.character = character;
    notifyListeners();
  }

  Future<List<EpisodeModel>> consultEpisodes() async {
    episodes = [];
    episodes = await Services().getEpisodes(character!.episode!);
    return episodes!;
  }

  openLocation(BuildContext context) async {
    List<LocationModel> location = await Services().getLocations(character!.location!.url!);
    // ignore: use_build_context_synchronously
    context.read<LocationInformationController>().updateLocation(location[0]);
    //go to screen
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/locationInformation');
  }

  openOrigin(BuildContext context) async {
    List<LocationModel> location = await Services().getLocations(character!.origin!.url!);
    // ignore: use_build_context_synchronously
    context.read<LocationInformationController>().updateLocation(location[0]);
    //go to screen
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/locationInformation');
  }
}
