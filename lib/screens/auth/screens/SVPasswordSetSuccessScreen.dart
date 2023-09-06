import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:home_hub/utils/SVCommon.dart';

class SVPasswordSetSuccessScreen extends StatelessWidget {
  const SVPasswordSetSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              100.height,
              Image.asset('assets/images/gifs/success_tickmark.gif',
                      fit: BoxFit.cover)
                  .paddingOnly(left: 30, right: 30),
              Text('Tu contraseña fue cambiada',
                  style: boldTextStyle(size: 24)),
              Text('¡Satisfactoriamente !',
                  style: boldTextStyle(size: 24, color: Color(0xFF00A66C))),
            ],
          ),
          svAppButton(
            context: context,
            text: 'HECHO',
            onTap: () {
              finish(context);
              finish(context);
              finish(context);
              finish(context);
            },
          ).paddingSymmetric(vertical: 20),
        ],
      ),
    );
  }
}
