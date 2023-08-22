import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models.dart/location_model.dart';
import 'package:rick_and_morty_app/styles/colors.dart';
import 'package:rick_and_morty_app/views/locations/locations_controller.dart';
import 'package:search_page/search_page.dart';

import '../../data/strings.dart';
import '../../styles/textStyles.dart';

class LocationsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LocationsViewState();
  }
}

class LocationsViewState extends State<LocationsView> {
  Future<List<LocationModel>>? locations;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LocationsController>().restartVariables();
    locations = context.read<LocationsController>().consultLocations();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 45,
          backgroundColor: baseBlue,
          title: finderWidget(context, () {
            return context.read<LocationsController>().consultFinder();
          }),
          centerTitle: true,
        ),
        body: RefreshIndicator(
            color: brown,
            onRefresh: refresh,
            child: FutureBuilder<List<LocationModel>>(
                future: locations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (context.watch<LocationsController>().locations.isNotEmpty) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height - 145,
                            child: ListView.builder(
                                // physics: const NeverScrollableScrollPhysics(),

                                itemCount: context.watch<LocationsController>().locations.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == context.watch<LocationsController>().locations.length) {
                                    return context.watch<LocationsController>().enableShowMoreButton
                                        ? TextButton(
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                txtShowMore,
                                                style: styleShowMoreButton,
                                              )),
                                            ),
                                            onPressed: () async {
                                              await context.read<LocationsController>().showMore();
                                            },
                                          )
                                        : Container();
                                  } else {
                                    return locationCard(context, context.watch<LocationsController>().locations[index]);
                                  }
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
                })));
  }

  Widget finderWidget(BuildContext context, Function funcion) {
    return FutureBuilder<List<LocationModel>>(
        future: funcion(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return InkWell(
              child: Container(
                height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    maxLines: 1,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: grey, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: grey, width: 2.0),
                      ),
                      hintText: txtSearch,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                showSearch(
                  context: context,
                  delegate: SearchPage<LocationModel>(
                    items: snapshot.data!,
                    barTheme: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(primary: baseBlue), hintColor: Colors.white),
                    searchStyle: styleSearch,
                    searchLabel: txtSearch,
                    suggestion: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            width: 150,
                            height: 150,
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 150,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            child: Text(
                              txtTypeAKeyword,
                              style: styleKeywordSearch,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    failure: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            width: 150,
                            height: 150,
                            child: Icon(
                              Icons.error,
                              color: Colors.grey,
                              size: 150,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            child: Text(
                              txtNoResults,
                              style: styleKeywordSearch,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    filter: (location) => [location.id.toString(), location.name, location.type, location.dimension],
                    builder: (location) => Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: locationCard(context, location),
                    ),
                  ),
                );
              },
            );
          } else {
            return SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.fallingDot(
                    color: grey,
                    size: 50,
                  ),
                ],
              ),
            );
          }
        });
  }

  locationCard(BuildContext context, LocationModel location) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: purple, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(children: [
        TextButton(
          onPressed: () {
            //update the location
            context.read<LocationsController>().openLocationInformation(context, location);
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
                      location.name!,
                      style: styleLocationName,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          txtType,
                          style: styleCharacterItem,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          location.type!.toString(),
                          style: styleEpisodeNumber,
                          textAlign: TextAlign.start,
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

  Future<void> refresh() async {
    setState(() {});
  }
}
