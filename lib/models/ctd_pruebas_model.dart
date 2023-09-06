import 'dart:convert';

import 'package:home_hub/utils/constant.dart';
import 'package:http/http.dart' as http;

class Pruebas {
  String name;
  String description;

  Pruebas({
    required this.name,
    required this.description,
  });

  factory Pruebas.fromJson(Map<String, dynamic> json) => Pruebas(
        name: json["name"],
        description: json["descripcion"],
      );
}

Future<List<Pruebas>> getPruebas() async {
  final response = await http.get(Uri.parse(apiUrl + "/pruebas"));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<Pruebas> users = [];
    for (var u in jsonResponse) {
      Pruebas user = Pruebas(name: u['nombre'], description: u['descripcion']);
      users.add(user);
    }
    return users;
  } else {
    throw Exception('Failed to load post');
  }
}
