import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/models.dart/location_model.dart';

import '../../models.dart/character_model.dart';
import '../../services/services.dart';

class LocationInformationController with ChangeNotifier, DiagnosticableTreeMixin {
  LocationModel? location;
  List<CharacterModel>? characters;

  updateLocation(LocationModel location) {
    this.location = location;
    notifyListeners();
  }

  Future<List<CharacterModel>> consultCharacters() async {
    characters = [];
    characters = await Services().getCharacters(location!.residents!);
    return characters!;
  }
}
