import 'package:flutter/material.dart';
import 'package:home_hub/custom_widget/space.dart';
import 'package:home_hub/models/ctd_services_model.dart';
import 'package:home_hub/screens/service_screen.dart';

class CtdHomeComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        children: List.generate(
          ctdServices.length,
          (index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ServiceScreen(index: index, fromRenovate: true)),
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
                        child: Image.asset(ctdServices[index].imagePath!,
                            fit: BoxFit.cover),
                      )),
                  Space(8),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    ctdServices[index].title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
