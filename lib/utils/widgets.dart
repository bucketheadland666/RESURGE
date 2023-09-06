import 'package:flutter/material.dart';
import 'package:home_hub/models/last_bookings_model.dart';
import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:home_hub/utils/colors.dart';

import '../main.dart';

//-------------
//Titulo nivel 1
Widget title1(String? titleText) {
  return Text(
    titleText.toString(),
    textAlign: TextAlign.start,
    style: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 18,
      color: appData.isDark ? whiteColor : primaryColor,
    ),
  );
}

Widget title2(String? titleText) {
  return Text(
    titleText.toString(),
    textAlign: TextAlign.start,
    style: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 20,
      color: appData.isDark ? whiteColor : primaryColor,
    ),
  );
}

Widget title1Center(String? titleText) {
  return Text(
    titleText.toString(),
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 18,
      color: appData.isDark ? whiteColor : primaryColor,
    ),
  );
}

//-------------
//Texto parrafo
Widget paragraphText(String? paragraphText) {
  return Text(
    paragraphText.toString(),
    overflow: TextOverflow.ellipsis,
    maxLines: 10,
    textAlign: TextAlign.justify,
    style: TextStyle(color: subTitle, fontSize: 14),
  );
}

//-------------
InputDecoration commonInputDecoration(
    {String? hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: textFieldColor,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(color: hintTextColor, fontSize: 16),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  );
}

Widget homeTitleWidget({
  String? titleText,
  String? viewAllText,
  Function()? onAllTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titleText!,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: appData.isDark ? whiteColor : primaryColor)),
        TextButton(
          child: Text(
            viewAllText ?? "Ver todo",
            style: TextStyle(
                color: viewAllColor,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          onPressed: onAllTap!,
        ),
      ],
    ),
  );
}

Widget drawerWidget(
    {String? drawerTitle, Function()? drawerOnTap, IconData? drawerIcon}) {
  return ListTile(
    horizontalTitleGap: 0,
    visualDensity: VisualDensity.compact,
    leading: Icon(drawerIcon!, size: 20),
    title: Text(drawerTitle!, style: TextStyle()),
    onTap: drawerOnTap!,
  );
}

Future<void> showAlertDialog(BuildContext context, {int? index}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure to book that service again?'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              againBooking(index!);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashBoardScreen()),
                  (route) => false);
            },
          ),
        ],
      );
    },
  );
}
