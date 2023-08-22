class LocationModel {
  int? id;
  String? name;
  String? type;
  String? dimension;
  String? residents;
  String? url;
  DateTime? created;

  LocationModel(
      {required this.id,
      required this.name,
      required this.type,
      required this.dimension,
      required this.residents,
      required this.url,
      required this.created});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    dimension = json['dimension'];
    residents = charactersData(json['residents'].cast<String>());
    url = json['url'];
    created = DateTime.parse(json['created']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['dimension'] = this.dimension;
    data['residents'] = this.residents;
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
