import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:home_hub/screens/auth/screens/SVOTPScreen.dart';
import 'package:home_hub/screens/auth/screens/SVSignInScreen.dart';
import 'package:home_hub/utils/SVCommon.dart';

class SVForgetPasswordScreen extends StatelessWidget {
  const SVForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: svGetScaffoldColor(),
      body: Column(
        children: [
          SizedBox(height: context.statusBarHeight + 30),
          svHeaderContainer(
            child: Text(
              '¿Olvide mi contraseña?',
              style: boldTextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ).paddingOnly(bottom: 16),
            context: context,
          ),
          Container(
            width: context.width(),
            color: context.cardColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  20.height,
                  svRobotoText(
                      text:
                          'Ingresa el correo electrónico asociado a tu cuenta \n para recibir un código y restablecer tu contraseña.'),
                  30.height,
                  AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    textStyle: boldTextStyle(),
                    decoration: svInputDecoration(
                      context,
                      label: 'Ingresa tu correo electrónico',
                      labelStyle: secondaryTextStyle(
                          weight: FontWeight.w600, color: svGetBodyColor()),
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  100.height,
                  svAppButton(
                    context: context,
                    text: 'OBTENER CÓDIGO',
                    onTap: () {
                      SVOTPScreen().launch(context);
                    },
                  ),
                  16.height,
                  svRobotoText(
                    text: 'Regresae al inicio de seción',
                    color: Color(0XFF7B8BB2),
                    onTap: () {
                      finish(context);
                      SVSignInScreen().launch(context);
                    },
                  ),
                ],
              ),
            ),
          ).expand()
        ],
      ),
    );
  }
}
