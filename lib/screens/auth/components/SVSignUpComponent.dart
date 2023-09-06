import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:home_hub/utils/SVColors.dart';
import 'package:home_hub/utils/SVCommon.dart';

import '../../dashboard_screen.dart';

class SVSignUpComponent extends StatefulWidget {
  final VoidCallback? callback;

  SVSignUpComponent({this.callback});

  @override
  State<SVSignUpComponent> createState() => _SVSignUpComponentState();
}

class _SVSignUpComponentState extends State<SVSignUpComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      color: context.cardColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Text('Bienvenido',
                    style: boldTextStyle(
                        size: 24, color: Color.fromARGB(255, 28, 71, 158)))
                .paddingSymmetric(horizontal: 16),
            8.height,
            Text('Crea una cuenta para una mejor experiencia',
                    style: secondaryTextStyle(
                        weight: FontWeight.w500, color: svGetBodyColor()))
                .paddingSymmetric(horizontal: 16),
            Container(
              child: Column(
                children: [
                  20.height,
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    textStyle: boldTextStyle(),
                    decoration: svInputDecoration(
                      context,
                      label: 'Usuario',
                      labelStyle: secondaryTextStyle(
                          weight: FontWeight.w600, color: svGetBodyColor()),
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  8.height,
                  AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    textStyle: boldTextStyle(),
                    decoration: svInputDecoration(
                      context,
                      label: 'Correo electrónico',
                      labelStyle: secondaryTextStyle(
                          weight: FontWeight.w600, color: svGetBodyColor()),
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    textStyle: boldTextStyle(),
                    suffixIconColor: svGetBodyColor(),
                    suffixPasswordInvisibleWidget: Image.asset(
                            'assets/icons/ic_Hide.png',
                            height: 16,
                            width: 16,
                            fit: BoxFit.fill)
                        .paddingSymmetric(vertical: 16, horizontal: 14),
                    suffixPasswordVisibleWidget:
                        svRobotoText(text: 'Ver', color: SVAppColorPrimary)
                            .paddingOnly(top: 20),
                    decoration: svInputDecoration(
                      context,
                      label: 'Contraseña',
                      contentPadding: EdgeInsets.all(0),
                      labelStyle: secondaryTextStyle(
                          weight: FontWeight.w600, color: svGetBodyColor()),
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  10.height,
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    decoration: svInputDecoration(
                      context,
                      label: 'Celular',
                      prefix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('+593', style: boldTextStyle(size: 14)),
                          6.width,
                          Icon(Icons.keyboard_arrow_down,
                              size: 16, color: svGetBodyColor()),
                        ],
                      ),
                      labelStyle: secondaryTextStyle(
                          weight: FontWeight.w600, color: svGetBodyColor()),
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  40.height,
                  svAppButton(
                    context: context,
                    text: 'REGISTRARSE',
                    onTap: () {
                      DashBoardScreen().launch(context);
                    },
                  ),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      svRobotoText(text: '¿Ya tienes una cuenta? '),
                      4.width,
                      Text(
                        '¡Inicia sesión aquí!',
                        style: secondaryTextStyle(
                            color: SVAppColorPrimary,
                            decoration: TextDecoration.underline),
                      ).onTap(() {
                        widget.callback?.call();
                      },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent)
                    ],
                  ),
                  40.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
