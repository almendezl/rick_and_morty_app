class CharacterModel {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Origin? origin;
  Origin? location;
  String? image;
  String? episode;
  String? url;
  DateTime? created;

  CharacterModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.origin,
      required this.location,
      required this.image,
      required this.episode,
      required this.url,
      required this.created});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin = (json['origin'] != null ? Origin.fromJson(json['origin']) : null)!;
    location = (json['location'] != null ? Origin.fromJson(json['location']) : null)!;
    image = json['image'];
    episode = episodesData(json['episode'].cast<String>());
    url = json['url'];
    created = DateTime.parse(json['created']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['species'] = this.species;
    data['type'] = this.type;
    data['gender'] = this.gender;
    if (this.origin != null) {
      data['origin'] = this.origin!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['image'] = this.image;
    data['episode'] = this.episode;
    data['url'] = this.url;
    data['created'] = this.created;
    return data;
  }

  String episodesData(List<String> urls) {
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

class Origin {
  String? name;
  String? url;

  Origin({required this.name, required this.url});

  Origin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = getNumber(json['url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }

  String getNumber(String url) {
    List<String> partes = url.split('/');
    String lastNumber = partes.last;
    return lastNumber;
  }
}
