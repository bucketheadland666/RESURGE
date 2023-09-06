import 'package:flutter/material.dart';
import 'package:home_hub/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Carousel Example',
      home: ImageCarousel(),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://d8fd-138-185-139-54.ngrok-free.app/pruebas'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Replace 'specific_item' with the item you're looking for
      final filteredData = data.where((item) =>
          item['nombre'] ==
          'uno'); // Change 'nombre' to the field you want to filter on

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
        print(imageUrls);
      });
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Carousel from API'),
      ),
      body: imageUrls.isEmpty
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
                    return Image.network(
                      apiUrl + imageUrl,
                      fit: BoxFit.cover,
                    );
                  },
                );
              }).toList(),
            ),
    );
  }
}
