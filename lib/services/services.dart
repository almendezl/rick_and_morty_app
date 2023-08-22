import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/models.dart/character_model.dart';
import 'package:rick_and_morty_app/models.dart/episode_model.dart';
import 'package:rick_and_morty_app/models.dart/location_model.dart';

class Services {
  final String baseUrl = 'https://rickandmortyapi.com/api/';

  Future<List<CharacterModel>> getCharacters(String length) async {
    final response = await http.get(Uri.parse('${baseUrl}character/$length'));

    if (response.statusCode == 200) {
      if (length.contains(',')) {
        final data = json.decode(response.body);
        final jsonData = data as List<dynamic>;

        List<CharacterModel> characters = jsonData.map((data) {
          return CharacterModel.fromJson(data as Map<String, dynamic>);
        }).toList();

        return characters;
      } else {
        final data = json.decode(response.body);
        List<CharacterModel> list = [CharacterModel.fromJson(data as Map<String, dynamic>)];

        return list;
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<LocationModel>> getLocations(String length) async {
    final response = await http.get(Uri.parse('${baseUrl}location/$length'));

    if (response.statusCode == 200) {
      if (length.contains(',')) {
        final data = json.decode(response.body);
        final jsonData = data as List<dynamic>;

        List<LocationModel> locations = jsonData.map((data) {
          return LocationModel.fromJson(data as Map<String, dynamic>);
        }).toList();

        return locations;
      } else {
        final data = json.decode(response.body);
        List<LocationModel> list = [LocationModel.fromJson(data as Map<String, dynamic>)];

        return list;
      }
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<List<EpisodeModel>> getEpisodes(String length) async {
    print(length);
    final response = await http.get(Uri.parse('${baseUrl}episode/$length'));

    if (response.statusCode == 200) {
      if (length.contains(',')) {
        final data = json.decode(response.body);
        final jsonData = data as List<dynamic>;
        List<EpisodeModel> episodes = jsonData.map((data) {
          return EpisodeModel.fromJson(data as Map<String, dynamic>);
        }).toList();
        return episodes;
      } else {
        final data = json.decode(response.body);
        List<EpisodeModel> list = [EpisodeModel.fromJson(data as Map<String, dynamic>)];

        return list;
      }
    } else {
      throw Exception('Failed to load episodes');
    }
  }
}
