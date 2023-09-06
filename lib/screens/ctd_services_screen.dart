//PANTALL SERVICIOS
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_hub/screens/ctd_services_screen_detail.dart';
import 'package:home_hub/utils/widgets.dart';

import '../custom_widget/space.dart';
import '../models/ctd_services_model.dart';
import '../utils/colors.dart';
//para consumir el api
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

class CtdServiceScreen extends StatefulWidget {
  final int serviceIndex = 0;
  final int index = 0;

  const CtdServiceScreen({Key? key}) : super(key: key);

  @override
  State<CtdServiceScreen> createState() => _CtdServiceScreenState();
}

class _CtdServiceScreenState extends State<CtdServiceScreen> {
//=========================================
  late Future<List<ServicesModel>> _listServices;
  Future<List<ServicesModel>> _getServices() async {
    final response = await http.get(Uri.parse(apiUrl + "/servicios"));

    List<ServicesModel> lstServices = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jasonData = jsonDecode(body);
      //print(jasonData[3]['descripcion']);
      for (var item in jasonData) {
        lstServices.add(ServicesModel(item["id"], item["nombre"],
            item["descripcion"], item["multimedia"][0]['url']));
        //print(item["multimedia"][0]['url']);
      }
      // print(aboutUs);
    } else {
      print("Fallo la conexion");
      throw Exception("Falloooo");
    }
    return lstServices;
  }

//========================================
  @override
  void initState() {
    super.initState();
    _listServices = _getServices();
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
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: FutureBuilder(
                      future: _listServices,
                      builder:
                          (BuildContext ctx, AsyncSnapshot<List> snapshot) {
                        if (snapshot.hasData) {
                          var value = '';
                          for (var i = 0; i < snapshot.data!.length; i++) {
                            if (snapshot.data![i].name == "Descripción") {
                              value = snapshot.data![i].description;
                            }
                          }
                          return paragraphText(value);
                        } else if (snapshot.hasError) {
                          print("Error");
                        }
                        return Center(child: CircularProgressIndicator());
                      })),
              Space(8),
              //TITULO
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: title1('Todos los servicios')),
              //CARD SERVICIOS
              Container(
                height: 540,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: FutureBuilder<List<ServicesModel>>(
                      future: _listServices,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 50,
                                  shadowColor: Colors.black,
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: 300,
                                    height: 400,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: primaryColor,
                                            radius: 84,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(apiUrl +
                                                  snapshot.data![index]
                                                      .multimedia), //NetworkImage
                                              radius: 80,
                                            ), //CircleAvatar
                                          ), //CircleAvatar
                                          const SizedBox(
                                            height: 10,
                                          ), //SizedBox
                                          title1(snapshot
                                              .data![index].name), //Text
                                          const SizedBox(
                                            height: 10,
                                          ), //SizedBox
                                          Text(
                                              snapshot.data![index].description,
                                              maxLines: 3,
                                              textAlign: TextAlign.justify,
                                              overflow: TextOverflow.ellipsis),
                                          //Textstyle
                                          //Text
                                          const SizedBox(
                                            height: 10,
                                          ), //SizedBox
                                          SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                              onPressed: () => {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CtdServiceScreenDetail(
                                                              indexservices:
                                                                  (index + 1))),
                                                )
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primaryColor)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.touch_app),
                                                    Text('Ver')
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ) //SizedBox
                                        ],
                                      ), //Column
                                    ), //Padding
                                  ), //SizedBox
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
            ],
          ),
        ),
      ),
    );
  }
}
