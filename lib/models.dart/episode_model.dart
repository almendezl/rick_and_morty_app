class EpisodeModel {
  int? id;
  String? name;
  String? airDate;
  String? episode;
  String? characters;
  String? url;
  DateTime? created;

  EpisodeModel(
      {required this.id,
      required this.name,
      required this.airDate,
      required this.episode,
      required this.characters,
      required this.url,
      required this.created});

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    airDate = json['air_date'];
    episode = json['episode'];
    characters = charactersData(json['characters'].cast<String>());
    url = json['url'];
    created = DateTime.parse(json['created']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['air_date'] = this.airDate;
    data['episode'] = this.episode;
    data['characters'] = this.characters;
    data['url'] = this.url;
    data['created'] = this.created;
    return data;
  }

  String charactersData(List<String> urls) {
    List<String> numbers = [];

    for (String url in urls) {
      List<String> partes = url.split('/');
      String lastNumber = partes.last;
      numbers.add(lastNumber);
    }

    // Usar join para combinar los números en un solo String separado por comas
    String data = numbers.join(',');
    return data;
  }
}
