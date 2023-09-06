// To parse this JSON data, do
//
//     final secciones = seccionesFromJson(jsonString);

import 'dart:convert';

List<Secciones> seccionesFromJson(String str) =>
    List<Secciones>.from(json.decode(str).map((x) => Secciones.fromJson(x)));

String seccionesToJson(List<Secciones> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Secciones {
  Secciones({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    this.secciones,
    this.idSecciones,
    this.nombreSeccion,
    required this.multimedia,
  });

  int id;
  String nombre;
  String descripcion;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int? secciones;
  int? idSecciones;
  NombreSeccion? nombreSeccion;
  List<Multimedia> multimedia;

  factory Secciones.fromJson(Map<String, dynamic> json) => Secciones(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        secciones: json["secciones"],
        idSecciones: json["id_secciones"],
        nombreSeccion: json["nombre_seccion"] == null
            ? null
            : NombreSeccion.fromJson(json["nombre_seccion"]),
        multimedia: List<Multimedia>.from(
            json["multimedia"].map((x) => Multimedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "secciones": secciones,
        "id_secciones": idSecciones,
        "nombre_seccion": nombreSeccion?.toJson(),
        "multimedia": List<dynamic>.from(multimedia.map((x) => x.toJson())),
      };
}

class Multimedia {
  Multimedia({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    this.width,
    this.height,
    this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String alternativeText;
  String caption;
  int? width;
  int? height;
  Formats? formats;
  String hash;
  Ext ext;
  Mime mime;
  double size;
  String url;
  dynamic previewUrl;
  Provider provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats:
            json["formats"] == null ? null : Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: extValues.map[json["ext"]]!,
        mime: mimeValues.map[json["mime"]]!,
        size: json["size"]?.toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: providerValues.map[json["provider"]]!,
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats?.toJson(),
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": providerValues.reverse[provider],
        "provider_metadata": providerMetadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Ext { JPEG, JPG, PNG, MP4 }

final extValues = EnumValues(
    {".jpeg": Ext.JPEG, ".jpg": Ext.JPG, ".mp4": Ext.MP4, ".png": Ext.PNG});

class Formats {
  Formats({
    required this.thumbnail,
    this.large,
    this.medium,
    required this.small,
  });

  Small thumbnail;
  Small? large;
  Small? medium;
  Small small;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Small.fromJson(json["thumbnail"]),
        large: json["large"] == null ? null : Small.fromJson(json["large"]),
        medium: json["medium"] == null ? null : Small.fromJson(json["medium"]),
        small: Small.fromJson(json["small"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "large": large?.toJson(),
        "medium": medium?.toJson(),
        "small": small.toJson(),
      };
}

class Small {
  Small({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.width,
    required this.height,
    required this.size,
    this.path,
    required this.url,
  });

  String name;
  String hash;
  Ext ext;
  Mime mime;
  int width;
  int height;
  double size;
  dynamic path;
  String url;

  factory Small.fromJson(Map<String, dynamic> json) => Small(
        name: json["name"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]]!,
        mime: mimeValues.map[json["mime"]]!,
        width: json["width"],
        height: json["height"],
        size: json["size"]?.toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}

enum Mime { IMAGE_JPEG, IMAGE_PNG, VIDEO_MP4 }

final mimeValues = EnumValues({
  "image/jpeg": Mime.IMAGE_JPEG,
  "image/png": Mime.IMAGE_PNG,
  "video/mp4": Mime.VIDEO_MP4
});

enum Provider { LOCAL }

final providerValues = EnumValues({"local": Provider.LOCAL});

class NombreSeccion {
  NombreSeccion({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.multimedia,
  });

  int id;
  Nombre nombre;
  String descripcion;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Multimedia> multimedia;

  factory NombreSeccion.fromJson(Map<String, dynamic> json) => NombreSeccion(
        id: json["id"],
        nombre: nombreValues.map[json["nombre"]]!,
        descripcion: json["descripcion"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        multimedia: List<Multimedia>.from(
            json["multimedia"].map((x) => Multimedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombreValues.reverse[nombre],
        "descripcion": descripcion,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "multimedia": List<dynamic>.from(multimedia.map((x) => x.toJson())),
      };
}

enum Nombre { SOBRE_NOSOTROS, INSTALACIONES, SERVICIOS }

final nombreValues = EnumValues({
  "Instalaciones": Nombre.INSTALACIONES,
  "Servicios": Nombre.SERVICIOS,
  "Sobre nosotros": Nombre.SOBRE_NOSOTROS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
