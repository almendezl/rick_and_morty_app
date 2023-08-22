import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../data/strings.dart';
import '../../models.dart/character_model.dart';
import '../../styles/colors.dart';
import '../../styles/textStyles.dart';
import '../../widgets/characterCard.dart';
import 'episodeInformation_controller.dart';

class EpisodeInformationView extends StatelessWidget {
  const EpisodeInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(context.read<EpisodeInformationController>().episode!.name!),
          backgroundColor: baseBlue,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.read<EpisodeInformationController>().episode!.name!,
                      style: styleCharacterInformationName,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtSpecies,
                          style: styleCharacterItem,
                        ),
                        Text(
                          context.read<EpisodeInformationController>().episode!.id!.toString(),
                          style: styleCharacterInformationDetail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtAirDate,
                          style: styleCharacterItem,
                        ),
                        Text(
                          context.read<EpisodeInformationController>().episode!.airDate!,
                          style: styleCharacterInformationDetail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtEpisode,
                          style: styleCharacterItem,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          context.read<EpisodeInformationController>().episode!.episode!,
                          style: styleCharacterInformationDetail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtCreated,
                          style: styleCharacterItem,
                        ),
                        Text(
                          DateFormat('dd/MM/yy').format(context.read<EpisodeInformationController>().episode!.created!),
                          style: styleCharacterInformationDetail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      txtCharactersSubtitle,
                      style: styleCharacterItem,
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<List<CharacterModel>>(
                        future: context.read<EpisodeInformationController>().consultCharacters(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (context.watch<EpisodeInformationController>().characters!.isNotEmpty) {
                              return Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height - 210,
                                    child: ListView.builder(
                                        // physics: const NeverScrollableScrollPhysics(),

                                        itemCount: context.watch<EpisodeInformationController>().characters!.length,
                                        itemBuilder: (context, index) {
                                          return characterCard(context, context.watch<EpisodeInformationController>().characters![index]);
                                        }),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: Text(
                                  txtNoResults,
                                  style: styleCharacterItem,
                                ),
                              );
                            }
                          } else {
                            return Center(
                              child: LoadingAnimationWidget.fallingDot(
                                color: baseBlue,
                                size: 50,
                              ),
                            );
                          }
                        })
                  ],
                )),
          ]),
        ));
  }
}
