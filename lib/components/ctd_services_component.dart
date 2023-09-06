//NUESTROS SERVICIOS COMPONENT
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_hub/custom_widget/space.dart';
import 'package:home_hub/models/ctd_services_model.dart';
import 'package:home_hub/screens/ctd_services_screen_detail.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

class CtdServicesComponent extends StatefulWidget {
  @override
  State<CtdServicesComponent> createState() => _CtdServicesComponentState();
}

class _CtdServicesComponentState extends State<CtdServicesComponent> {
  late Future<List<ServicesModel>> _listServices;
  Future<List<ServicesModel>> _getServices() async {
    final response = await http
        .get(Uri.parse("https://d8fd-138-185-139-54.ngrok-free.app/servicios"));

    List<ServicesModel> lstServices = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jasonData = jsonDecode(body);
      //print(jasonData[3]['descripcion']);
      for (var item in jasonData) {
        lstServices.add(ServicesModel(item["id"], item["nombre"],
            item["descripcion"], item["multimedia"][0]['url']));
        // print(item["multimedia"][0]['url']);
      }
      // print(aboutUs);
    } else {
      print("Fallo la conexion");
      throw Exception("Falloooo");
    }
    return lstServices;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listServices = _getServices();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 130,
        child: FutureBuilder(
          future: _listServices,
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              List imageServices = [];
              List nameServices = [];
              var valueUrl = "";

              for (var i = 0; i < snapshot.data!.length; i++) {
                valueUrl = apiUrl + snapshot.data![i].multimedia;
                nameServices.add(snapshot.data![i].name);
                imageServices.add(valueUrl);
              }

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  nameServices.length,
                  (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CtdServiceScreenDetail(
                                indexservices: (index + 1))),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                width: 160,
                                height: 100,
                                child: Image.network(imageServices[index],
                                    fit: BoxFit.cover),
                              )),
                          Space(8),
                          Text(
                            nameServices[index],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              print("Error");
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
