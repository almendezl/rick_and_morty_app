import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models.dart/episode_model.dart';
import 'package:rick_and_morty_app/styles/colors.dart';
import 'package:rick_and_morty_app/views/episodes/episodes_controller.dart';
import 'package:search_page/search_page.dart';

import '../../data/strings.dart';
import '../../styles/textStyles.dart';
import '../../widgets/episodeCard.dart';

class EpisodesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EpisodesViewState();
  }
}

class EpisodesViewState extends State<EpisodesView> {
  Future<List<EpisodeModel>>? episodes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<EpisodesController>().restartVariables();
    episodes = context.read<EpisodesController>().consultEpisodes();
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
            return context.read<EpisodesController>().consultFinder();
          }),
          centerTitle: true,
        ),
        body: RefreshIndicator(
            color: brown,
            onRefresh: refresh,
            child: FutureBuilder<List<EpisodeModel>>(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (context.watch<EpisodesController>().episodes.isNotEmpty) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height - 145,
                            child: ListView.builder(
                                // physics: const NeverScrollableScrollPhysics(),

                                itemCount: context.watch<EpisodesController>().episodes.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == context.watch<EpisodesController>().episodes.length) {
                                    return context.watch<EpisodesController>().enableShowMoreButton
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
                                              await context.read<EpisodesController>().showMore();
                                            },
                                          )
                                        : Container();
                                  } else {
                                    return episodeCard(context, context.watch<EpisodesController>().episodes[index]);
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
    return FutureBuilder<List<EpisodeModel>>(
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
                  delegate: SearchPage<EpisodeModel>(
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
                    filter: (episode) => [episode.name, episode.episode, episode.id.toString()],
                    builder: (episode) => Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: episodeCard(context, episode),
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

  Future<void> refresh() async {
    setState(() {});
  }
}
