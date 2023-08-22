import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/data/strings.dart';
import 'package:rick_and_morty_app/models.dart/episode_model.dart';
import 'package:rick_and_morty_app/styles/colors.dart';
import 'package:rick_and_morty_app/views/characterInformation/characterInformation_controller.dart';
import 'package:rick_and_morty_app/widgets/episodeCard.dart';

import '../../styles/textStyles.dart';

class CharacterInformationView extends StatelessWidget {
  const CharacterInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(context.read<CharacterInformationController>().character!.name!),
          backgroundColor: baseBlue,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage(context.read<CharacterInformationController>().character!.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.read<CharacterInformationController>().character!.name!,
                      style: styleCharacterInformationName,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtStatus,
                          style: styleCharacterItem,
                        ),
                        Text(
                          context.read<CharacterInformationController>().character!.status!,
                          style: context.read<CharacterInformationController>().character!.status! == txtStatusAlive
                              ? styleCharacterStatusAlive
                              : styleCharacterStatusDead,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtSpecies,
                          style: styleCharacterItem,
                        ),
                        Text(
                          context.read<CharacterInformationController>().character!.species!,
                          style: styleCharacterInformationDetail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtGender,
                          style: styleCharacterItem,
                        ),
                        Text(
                          context.read<CharacterInformationController>().character!.gender!,
                          style: styleCharacterInformationDetail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          txtOrigin,
                          style: styleCharacterItem,
                          textAlign: TextAlign.start,
                        ),
                        context.read<CharacterInformationController>().character!.origin!.name! != 'unknown'
                            ? TextButton(
                                onPressed: () {
                                  context.read<CharacterInformationController>().openOrigin(context);
                                },
                                child: Text(
                                  txtShow,
                                  textAlign: TextAlign.start,
                                  style: styleCharacterInformationButton,
                                ))
                            : const Text(''),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.read<CharacterInformationController>().character!.origin!.name!,
                      style: styleCharacterInformationDetail,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          txtLocation,
                          style: styleCharacterItem,
                          textAlign: TextAlign.start,
                        ),
                        context.read<CharacterInformationController>().character!.location!.name! != 'unknow'
                            ? TextButton(
                                onPressed: () {
                                  context.read<CharacterInformationController>().openLocation(context);
                                },
                                child: Text(
                                  txtShow,
                                  textAlign: TextAlign.start,
                                  style: styleCharacterInformationButton,
                                ))
                            : const Text('')
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.read<CharacterInformationController>().character!.location!.name!,
                      style: styleCharacterInformationDetail,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtCreated,
                          style: styleCharacterItem,
                        ),
                        Text(
                          DateFormat('dd/MM/yy').format(context.read<CharacterInformationController>().character!.created!),
                          style: styleCharacterInformationDetail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      txtEpisode,
                      style: styleCharacterItem,
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<List<EpisodeModel>>(
                        future: context.read<CharacterInformationController>().consultEpisodes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (context.watch<CharacterInformationController>().episodes!.isNotEmpty) {
                              return Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: context.watch<CharacterInformationController>().episodes!.length * 150,
                                    child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: context.watch<CharacterInformationController>().episodes!.length,
                                        itemBuilder: (context, index) {
                                          return episodeCard(context, context.watch<CharacterInformationController>().episodes![index]);
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
