import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));
String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  int id;
  String name;
  double latitude;
  double longitude;
  int? population;
  List<String>? postcodes;
  String country;
  String admin1;
  String? admin2;
  String? admin3;

  Place({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.population,
    this.postcodes,
    required this.country,
    required this.admin1,
    this.admin2,
    this.admin3,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    id: json["id"],
    name: json["name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    population: json["population"],
    postcodes: json["postcodes"] == null
        ? []
        : List<String>.from(json["postcodes"]!.map((x) => x)),
    country: json["country"],
    admin1: json["admin1"],
    admin2: json["admin2"],
    admin3: json["admin3"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "population": population,
    "postcodes": postcodes == null
        ? []
        : List<dynamic>.from(postcodes!.map((x) => x)),
    "country": country,
    "admin1": admin1,
    "admin2": admin2,
    "admin3": admin3,
  };
}
