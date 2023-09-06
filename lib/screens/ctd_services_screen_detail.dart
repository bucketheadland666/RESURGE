import 'dart:convert';
import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:home_hub/utils/widgets.dart';

import '../custom_widget/space.dart';

import '../utils/colors.dart';
//para consumir el api
import 'package:http/http.dart' as http;
import 'package:home_hub/models/ctd_pruebas_model.dart';

import '../utils/constant.dart';

late Future<List<Pruebas>> _lstPruebas;
List<String> imageUrls = [];
var description;
var name;

class CtdServiceScreenDetail extends StatefulWidget {
  final int indexservices;

  CtdServiceScreenDetail({required this.indexservices});

  @override
  _TargetPageState createState() => _TargetPageState();
}

class _TargetPageState extends State<CtdServiceScreenDetail> {
//=============================================================
//GET ALL THE IMAGES FROM AND SPECIFIC ITEM
  Future<void> fetchDataMultimedia() async {
    final response = await http.get(
      Uri.parse(apiUrl + '/servicios'),
    );
    // print(x.toString());
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Replace 'specific_item' with the item you're looking for
      final filteredData = data.where((item) =>
          item['id'] ==
          widget
              .indexservices); // Change 'nombre' to the field you want to filter on
      final List<String> urls = [];
      // filteredData
      //     .map((item) => item['multimedia'][0]['url'].toString())
      //     .cast<String>()
      //     .toList();
      for (var item in filteredData) {
        for (var media in item['multimedia']) {
          urls.add(media['url']);
        }
      }
      setState(() {
        imageUrls = urls;
      });
      // print(imageUrls);
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

//=============================================================
//GET ALL THE INFORMATION FROM AN SPECIFIC ITEM
  Future<Map<String, dynamic>?> fetchItemById(int itemId) async {
    final apiUrl =
        'https://d8fd-138-185-139-54.ngrok-free.app/servicios/$itemId';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        // Handle errors here (e.g., item not found or API errors)
        return null;
      }
    } catch (e) {
      // Handle exceptions here
      return null;
    }
  }

  void getDataService() async {
    final itemId = widget
        .indexservices; // Replace with the ID of the specific item you want to retrieve
    final itemData = await fetchItemById(itemId);

    if (itemData != null) {
      print('Item Data for ID $itemId:');
      name = itemData['nombre'];
      description = itemData['descripcion'];
    } else {
      print('Item not found or an error occurred.');
    }
  }

//=============================================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lstPruebas = getPruebas();
    fetchDataMultimedia();
    getDataService();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: transparent,
          title: title1Center("Servicios"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space(8),
              Container(
                  child: imageUrls.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true,
                          ),
                          items: imageUrls.map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.network(apiUrl + imageUrl,
                                    fit: BoxFit.cover);
                              },
                            );
                          }).toList(),
                        )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: title1(name)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: paragraphText(description)),
              Container(
                  child: Center(
                child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                            Icons.visibility), // Replace with your desired icon
                        SizedBox(
                            width: 8), // Add some spacing between icon and text
                        Text(
                            'Ver en la galería'), // Replace with your button text
                      ],
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
