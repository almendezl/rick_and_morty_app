import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/strings.dart';
import '../models.dart/character_model.dart';
import '../styles/colors.dart';
import '../styles/textStyles.dart';
import '../views/characters/characters_controller.dart';

characterCard(BuildContext context, CharacterModel character) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    height: 120,
    decoration: BoxDecoration(
      border: Border.all(color: hardBlue, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: Row(children: [
      TextButton(
        onPressed: () {
          //update the character
          context.read<CharactersController>().openCharacterInformation(context, character);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage(character.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width - 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 190,
                        child: Text(
                          character.name!,
                          style: styleCharacterName,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        txtStatus,
                        style: styleCharacterItem,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        character.status!,
                        style: character.status! == txtStatusAlive ? styleCharacterStatusAlive : styleCharacterStatusDead,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    ]),
  );
}
