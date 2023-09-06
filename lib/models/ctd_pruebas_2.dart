import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/constant.dart';

class Item {
  final int id;
  final String nombre;
  final String descripcion;
  final String publishedAt;
  final String createdAt;
  final String updatedAt;
  final List<Map<String, dynamic>> multimedia;

  Item({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.multimedia,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      publishedAt: json['published_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      multimedia: List<Map<String, dynamic>>.from(json['multimedia']),
    );
  }
}

getdata() async {
  final apiUrl = 'https://d8fd-138-185-139-54.ngrok-free.app/pruebas';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    final List<Item> items =
        data.map((itemJson) => Item.fromJson(itemJson)).toList();

    for (var item in items) {
      print('Item ID: ${item.id}');
      print('Item Nombre: ${item.nombre}');
      print('--- Multimedia ---');
      for (var media in item.multimedia) {
        print('Media ID: ${media['id']}');
        print('Media Name: ${media['name']}');
        print('Media URL: ${media['url']}');
        print('---');
      }
    }
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}

getdata2() async {
  final response = await http.get(Uri.parse(apiUrl + '/pruebas'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    final List<Item> items =
        data.map((itemJson) => Item.fromJson(itemJson)).toList();

    List<String> urlImagenes = [];

    for (var item in items) {
      // print('Item ID: ${item.id}');
      // print('Item Nombre: ${item.nombre}');
      // print('--- Multimedia ---');
      if (item.id == 2) {
        for (var media in item.multimedia) {
          urlImagenes.add(media['url']);
          // print('Media ID: ${media['id']}');
          // print('Media Name: ${media['name']}');
          // print('Media URL: ${media['url']}');
          // print('---');
        }
      } else {
        print('naaaaaa');
      }
    }

    print(urlImagenes);
    return urlImagenes;
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
