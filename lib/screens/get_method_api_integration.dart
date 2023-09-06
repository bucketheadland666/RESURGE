import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/secciones.dart';
import '../network/remote_services.dart';

class GETMethodExampleScreen extends StatefulWidget {
  static String tag = '/GETMethodExampleScreen';

  @override
  GETMethodExampleScreenState createState() => GETMethodExampleScreenState();
}

List<Secciones>? secciones;
bool isLoaded = false;

class GETMethodExampleScreenState extends State<GETMethodExampleScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    secciones = await RemoteServices().getPost();
    if (secciones != null) {
      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WWW"),
      ),
      body: Visibility(
          child: ListView.builder(
              itemCount: secciones?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: boxDecorationRoundedWithShadow(8,
                      backgroundColor: Colors.amber),
                  child: Row(
                    children: [
                      Text(secciones![index].nombre),
                    ],
                  ),
                );
              }),
          replacement: const Center(
            child: Text("daaaaa"),
          )),
    );
  }
}
