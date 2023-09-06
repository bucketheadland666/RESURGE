import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:home_hub/screens/auth/screens/SVForgetPasswordScreen.dart';
import 'package:home_hub/utils/SVColors.dart';
import 'package:home_hub/utils/SVCommon.dart';

import '../../dashboard_screen.dart';

class SVLoginInComponent extends StatefulWidget {
  final VoidCallback? callback;

  SVLoginInComponent({this.callback});

  @override
  State<SVLoginInComponent> createState() => _SVLoginInComponentState();
}

class _SVLoginInComponentState extends State<SVLoginInComponent> {
  bool doRemember = false;

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
            Text('¡Bienvenido de nuevo!',
                    style: boldTextStyle(
                        size: 24, color: Color.fromARGB(255, 28, 71, 158)))
                .paddingSymmetric(horizontal: 16),
            8.height,
            Text('Te habías ausentado por un largo tiempo',
                    style: secondaryTextStyle(
                        weight: FontWeight.w500, color: svGetBodyColor()))
                .paddingSymmetric(horizontal: 16),
            Container(
              child: Column(
                children: [
                  20.height,
                  AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    textStyle: boldTextStyle(),
                    decoration: svInputDecoration(
                      context,
                      label: 'Usuario',
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
                  12.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            shape:
                                RoundedRectangleBorder(borderRadius: radius(2)),
                            activeColor: SVAppColorPrimary,
                            value: doRemember,
                            onChanged: (val) {
                              doRemember = val.validate();
                              setState(() {});
                            },
                          ),
                          svRobotoText(text: 'Recordarme'),
                        ],
                      ),
                      svRobotoText(
                        text: '¿Olvide mi contraseña?',
                        color: SVAppColorPrimary,
                        fontStyle: FontStyle.italic,
                        onTap: () {
                          SVForgetPasswordScreen().launch(context);
                        },
                      ).paddingSymmetric(horizontal: 16),
                    ],
                  ),
                  32.height,
                  svAppButton(
                    context: context,
                    text: 'INICIAR SESIÓN',
                    onTap: () {
                      DashBoardScreen().launch(context);
                    },
                  ),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      svRobotoText(text: '¿Aun no tienes una cuenta?'),
                      4.width,
                      Text(
                        'Regístrate aquí',
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
                  20.height,
                  svRobotoText(text: 'O registrate con:'),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/ic_GoogleColor.png',
                          height: 36, width: 36, fit: BoxFit.cover),
                      8.width,
                      Image.asset('assets/icons/ic_Facebook.png',
                          height: 36, width: 36, fit: BoxFit.cover),
                      8.width,
                      Image.asset('assets/icons/ic_Twitter.png',
                          height: 36, width: 36, fit: BoxFit.cover),
                    ],
                  ),
                  50.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
