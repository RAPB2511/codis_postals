import 'dart:convert';

import 'place.dart';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

// Model per gestionar la resposta general de l'API
class SearchResponse {
  List<Place> results;

  SearchResponse({required this.results});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    // Controlo que si no hi ha resultats (com el codi 99999), no fagi booooooom i retorni una llista buida
    results: json["results"] == null
        ? []
        : List<Place>.from(json["results"]!.map((x) => Place.fromJson(x))),
  );
}
