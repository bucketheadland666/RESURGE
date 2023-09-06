import 'dart:convert';

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

class TargetPage extends StatefulWidget {
  final String da;

  TargetPage({required this.da});

  @override
  _TargetPageState createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  void imprimir() {
    print(widget.da);
  }

//=========================================
//GET ALL THE IMAGES FROM AND SPECIFIC ITEM
  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(apiUrl + '/pruebas'),
    );
    // print(x.toString());
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Replace 'specific_item' with the item you're looking for
      final filteredData = data.where((item) =>
          item['nombre'] ==
          widget.da); // Change 'nombre' to the field you want to filter on
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
      print(imageUrls);
    } else {
      throw Exception('Failed to fetch data from API');
    }

    print(widget.da);
  }

//========================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imprimir();
    _lstPruebas = getPruebas();
    fetchData();
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

              Divider(
                height: 2,
                color: Colors.black,
              ),
              Container(
                child: Text('dddddddd'),
              ),
              Container(
                height: 540,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: FutureBuilder<List<Pruebas>>(
                      future: _lstPruebas,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(snapshot.data![index].name),
                                  subtitle:
                                      Text(snapshot.data![index].description),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
              Space(8),
              // Padding(
              //   padding: EdgeInsets.all(16),
              //   child: Stack(
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(10),
              //         child: Container(
              //           foregroundDecoration: BoxDecoration(
              //             gradient: LinearGradient(
              //               colors: [
              //                 blackColor,
              //                 transparent,
              //                 transparent,
              //                 transparent
              //               ],
              //               begin: Alignment.bottomCenter,
              //               end: Alignment.topCenter,
              //               stops: [0, 0.2, 0.8, 1],
              //             ),
              //           ),
              //           child: Image.network(
              //             "https://d8fd-138-185-139-54.ngrok-free.app//uploads/small_instalaciones_psicologia2_cc721bc2f4.jpeg?24945417",
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 16),
              //     child: FutureBuilder(
              //         future: _listServices,
              //         builder:
              //             (BuildContext ctx, AsyncSnapshot<List> snapshot) {
              //           if (snapshot.hasData) {
              //             var value = '';
              //             for (var i = 0; i < snapshot.data!.length; i++) {
              //               if (snapshot.data![i].name == "Descripción") {
              //                 value = snapshot.data![i].description;
              //               }
              //             }
              //             return paragraphText(value);
              //           } else if (snapshot.hasError) {
              //             print("Error");
              //           }
              //           return Center(child: CircularProgressIndicator());
              //         })),
              // Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     child: title1('Todos los servicios')),
              // Container(
              //     child: CarouselSlider(
              //   options: CarouselOptions(),
              //   items: list
              //       .map((item) => Container(
              //             child: Center(child: Text(item.toString())),
              //             color: Colors.green,
              //           ))
              //       .toList(),
              // )),
            ],
          ),
        ),
      ),
    );
  }
}
