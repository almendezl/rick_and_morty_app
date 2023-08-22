import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models.dart/episode_model.dart';
import '../styles/colors.dart';
import '../styles/textStyles.dart';
import '../views/episodes/episodes_controller.dart';

episodeCard(BuildContext context, EpisodeModel episode) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    height: 100,
    decoration: BoxDecoration(
      border: Border.all(color: green, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: Row(children: [
      TextButton(
        onPressed: () {
          //update the episode
          context.read<EpisodesController>().openEpisodeInformation(context, episode);
        },
        child: Row(
          children: [
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    episode.id!.toString(),
                    style: styleEpisodeNumber,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    episode.name!,
                    style: styleEpisodeName,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ]),
  );
}
