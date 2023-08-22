import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models.dart/episode_model.dart';
import 'package:rick_and_morty_app/views/episodeInformation/episodeInformation_controller.dart';

import '../../services/services.dart';
import '../../utils/generateLength.dart';

class EpisodesController with ChangeNotifier, DiagnosticableTreeMixin {
  List<EpisodeModel> episodes = [];
  List<EpisodeModel> episodesFinder = [];
  int episodesLength = 51;
  int start = 1;
  int end = 5;
  bool enableShowMoreButton = true;

  Future<List<EpisodeModel>> consultEpisodes() async {
    String length = generateLength(start, end);
    episodes = await Services().getEpisodes(length);

    return episodes;
  }

  Future<List<EpisodeModel>> consultFinder() async {
    String length = generateLength(start, end);
    episodesFinder = await Services().getEpisodes(length);

    return episodesFinder;
  }

  Future showMore() async {
    if (end + 5 <= episodesLength - 5) {
      start = end + 1;
      end = start + 4;
    } else {
      start = end + 1;
      end = episodesLength - end;
      enableShowMoreButton = false;
    }
    String length = generateLength(start, end);
    List<EpisodeModel> episodesList = await Services().getEpisodes(length);

    episodes.addAll(episodesList);
    notifyListeners();
  }

  openEpisodeInformation(BuildContext context, EpisodeModel episode) {
    context.read<EpisodeInformationController>().updateEpisode(episode);
    //go to screen
    Navigator.pushNamed(context, '/episodeInformation');
  }

  restartVariables() {
    start = 0;
    end = 5;
  }
}
