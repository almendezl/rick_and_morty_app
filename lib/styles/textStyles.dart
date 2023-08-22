import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/styles/colors.dart';

//Home styles
TextStyle selectedItemHome = textStyle(10, babyBlue, FontWeight.normal);
TextStyle unselectedItemHome = textStyle(10, grey, FontWeight.normal);

// characters styles
TextStyle styleTitleScreen = textStyle(25, white, FontWeight.bold);
TextStyle styleCharacterItem = textStyle(20, grey, FontWeight.bold);
TextStyle styleCharacterName = textStyle(22, baseBlue, FontWeight.bold);
TextStyle styleCharacterStatusAlive = textStyle(20, green, FontWeight.normal);
TextStyle styleCharacterStatusDead = textStyle(20, red, FontWeight.normal);

TextStyle styleShowMoreButton = textStyle(18, hardBlue, FontWeight.bold);

//Character information
TextStyle styleCharacterInformationName = textStyle(22, baseBlue, FontWeight.bold);
TextStyle styleCharacterInformationDetail = textStyle(20, black, FontWeight.normal);
TextStyle styleCharacterInformationButton = textStyle(18, orange, FontWeight.bold);

//Episodes styles
TextStyle styleEpisodeName = textStyle(20, hardGreen, FontWeight.bold);
TextStyle styleEpisodeNumber = textStyle(20, orange, FontWeight.bold);
//locations styles
TextStyle styleLocationName = textStyle(20, purple, FontWeight.bold);
//Widget search
TextStyle styleSearch = textStyle(18, white, FontWeight.bold);
TextStyle styleKeywordSearch = textStyle(20, grey, FontWeight.bold);
TextStyle styleNameBar = textStyle(20, white, FontWeight.bold);
//Function to create the text style
TextStyle textStyle(double size, Color color, FontWeight fontWeight) {
  return TextStyle(
    fontFamily: 'Bariol',
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}
