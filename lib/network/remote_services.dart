import 'package:http/http.dart' as http;

import '../models/secciones.dart';

class RemoteServices {
  Future<List<Secciones>?> getPost() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://ef69-2800-370-12c-f120-6899-a545-e4e7-81c4.ngrok-free.app/detalle-secciones/detalle-secciones');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return seccionesFromJson(json);
    }
    return null;
  }
}
