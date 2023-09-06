import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 150.0, bottom: 0.0),
              child: Image.asset(
                'assets/images/introduccion/logo_introduccion.png',
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Bienvenido",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'WorkSans',
                    // color: Color.fromRGBO(0, 155, 0, 0.8),
                    color: Color.fromARGB(255, 21, 60, 129)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: Text(
                // "Somos un Centro Especializado en Tratamiento a Personas con Consumo Problemático de Alcohol y Otras Drogas, que busca brindar atención de la más alta calidad al precio más bajo posible. Nuestro objetivo es brindar a nuestros clientes y sus familias una experiencia integral, positiva y efectiva que conduzca a una recuperación duradera.",
                "Al Centro especializado en el tratamiento de personas con consumo problemático de alcohol y otras Drogas 'RESURGE'",

                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'WorkSans'),
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38.0),
                      color: Color.fromARGB(255, 21, 60, 129)),
                  child: Text(
                    "Empecemos",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
