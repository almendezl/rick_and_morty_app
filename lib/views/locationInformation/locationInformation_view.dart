import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/views/locationInformation/locationInformation_controller.dart';

import '../../data/strings.dart';
import '../../models.dart/character_model.dart';
import '../../styles/colors.dart';
import '../../styles/textStyles.dart';
import '../../widgets/characterCard.dart';

class LocationInformationView extends StatelessWidget {
  const LocationInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            txtLocationTitle,
            style: styleNameBar,
          ),
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
                      context.read<LocationInformationController>().location!.name!,
                      style: styleCharacterInformationName,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtType,
                          style: styleCharacterItem,
                        ),
                        Text(
                          context.read<LocationInformationController>().location!.type!,
                          style: styleCharacterInformationDetail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          txtDimension,
                          style: styleCharacterItem,
                        ),
                        Text(
                          context.read<LocationInformationController>().location!.dimension!,
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
                          DateFormat('dd/MM/yy').format(context.read<LocationInformationController>().location!.created!),
                          style: styleCharacterInformationDetail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      txtResidents,
                      style: styleCharacterItem,
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<List<CharacterModel>>(
                        future: context.read<LocationInformationController>().consultCharacters(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (context.watch<LocationInformationController>().characters!.isNotEmpty) {
                              return Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: context.watch<LocationInformationController>().characters!.length * 130,
                                    child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: context.watch<LocationInformationController>().characters!.length,
                                        itemBuilder: (context, index) {
                                          return characterCard(context, context.watch<LocationInformationController>().characters![index]);
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
