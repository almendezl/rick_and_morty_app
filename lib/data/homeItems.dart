import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/strings.dart';
import 'package:rick_and_morty_app/views/characters/characters_view.dart';
import 'package:rick_and_morty_app/views/episodes/episodes_view.dart';
import 'package:rick_and_morty_app/views/locations/locations_view.dart';
import 'package:sizer/sizer.dart';

List<Widget> widgetOptions = <Widget>[
  //contain the views for each page in the navigator
  CharactersView(), LocationsView(), EpisodesView(),
];

List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(
      CupertinoIcons.person_crop_circle,
      size: 07.w,
    ),
    label: txtCharactersItem,
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.location_on,
      size: 07.w,
    ),
    label: txtLocationsItem,
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.movie_filter_rounded,
      size: 07.w,
    ),
    label: txtEpisodesItem,
  ),
];
