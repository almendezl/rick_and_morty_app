import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models.dart/character_model.dart';
import 'package:rick_and_morty_app/services/services.dart';
import 'package:rick_and_morty_app/views/characterInformation/characterInformation_controller.dart';

import '../../utils/generateLength.dart';

class CharactersController with ChangeNotifier, DiagnosticableTreeMixin {
  List<CharacterModel> characters = [];
  List<CharacterModel> charactersFinder = [];
  int characterslength = 826;
  int start = 1;
  int end = 5;
  bool enableShowMoreButton = true;

  Future<List<CharacterModel>> consultCharacters() async {
    String length = generateLength(start, end);
    characters = await Services().getCharacters(length);

    return characters;
  }

  Future<List<CharacterModel>> consultFinder() async {
    String length = generateLength(start, characterslength);
    charactersFinder = await Services().getCharacters(length);

    return charactersFinder;
  }

  Future showMore() async {
    if (end + 5 <= characterslength - 5) {
      start = end + 1;
      end = start + 4;
    } else {
      start = end + 1;
      end = characterslength - end;
      enableShowMoreButton = false;
    }
    characters = charactersFinder.sublist(0, end);
    notifyListeners();
  }

  restartVariables() {
    start = 0;
    end = 5;
  }

  openCharacterInformation(BuildContext context, CharacterModel character) {
    context.read<CharacterInformationController>().updateCharacter(character);
    //go to screen
    Navigator.pushNamed(context, '/characterInformation');
  }
}
