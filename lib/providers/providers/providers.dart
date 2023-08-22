import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rick_and_morty_app/views/bottomNavigation/bottomNavigation_controller.dart';
import 'package:rick_and_morty_app/views/characterInformation/characterInformation_controller.dart';
import 'package:rick_and_morty_app/views/characters/characters_controller.dart';
import 'package:rick_and_morty_app/views/episodeInformation/episodeInformation_controller.dart';
import 'package:rick_and_morty_app/views/episodes/episodes_controller.dart';
import 'package:rick_and_morty_app/views/locationInformation/locationInformation_controller.dart';
import 'package:rick_and_morty_app/views/locations/locations_controller.dart';

List<SingleChildWidget> providers = [
  //Provider for each view
  ChangeNotifierProvider(create: (_) => BottomNavigationController()),
  ChangeNotifierProvider(create: (_) => CharactersController()),
  ChangeNotifierProvider(create: (_) => LocationsController()),
  ChangeNotifierProvider(create: (_) => EpisodesController()),
  ChangeNotifierProvider(create: (_) => CharacterInformationController()),
  ChangeNotifierProvider(create: (_) => LocationInformationController()),
  ChangeNotifierProvider(create: (_) => EpisodeInformationController()),
];
