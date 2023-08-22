import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/views/characterInformation/characterInformation_view.dart';
import 'package:rick_and_morty_app/views/characters/characters_view.dart';
import 'package:rick_and_morty_app/views/episodeInformation/episodeInformation_view.dart';
import 'package:rick_and_morty_app/views/episodes/episodes_view.dart';
import 'package:rick_and_morty_app/views/locationInformation/locationInformation_view.dart';
import 'package:rick_and_morty_app/views/locations/locations_view.dart';

import '../views/bottomNavigation/bottomNavigation_view.dart';

getRoutes(BuildContext context) {
  return {
    '/': (context) => const BottomNavigationView(),
    '/characters': (context) => const CharactersView(),
    '/locations': (context) => LocationsView(),
    '/episodes': (context) => EpisodesView(),
    '/characterInformation': (context) => const CharacterInformationView(),
    '/locationInformation': (context) => const LocationInformationView(),
    '/episodeInformation': (context) => const EpisodeInformationView(),
  };
}
