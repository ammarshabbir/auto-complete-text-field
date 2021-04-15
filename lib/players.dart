import 'dart:convert';
import 'package:flutter/services.dart';

class Cities {
  String keyword;
  String autocompleteterm;
  String province;

  Cities({
    this.keyword,
    this.autocompleteterm,
    this.province
  });

  factory Cities.fromJson(Map<String, dynamic> parsedJson) {
    return Cities(
        keyword: parsedJson['keyword'] as String,
        autocompleteterm: parsedJson['autocompleteTerm'] as String,
        province: parsedJson['province'] as String
    );
  }
}

class CitiesViewModel {
  static List<Cities> cities;

  static Future loadCities() async {
    try {
      cities = new List<Cities>();
      String jsonString = await rootBundle.loadString('assets/cities.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['cities'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        cities.add(new Cities.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
