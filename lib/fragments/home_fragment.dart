import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:home_hub/components/combos_subscriptions_component.dart';
import 'package:home_hub/components/ctd_services_component.dart';
import 'package:home_hub/components/customer_review_component.dart';
import 'package:home_hub/components/home_contruction_component.dart';
import 'package:home_hub/components/home_service_component.dart';
import 'package:home_hub/components/popular_service_component.dart';
import 'package:home_hub/components/renovate_home_component.dart';
import 'package:home_hub/fragments/bookings_fragment.dart';

import 'package:home_hub/models/ctd_about_us.dart';
import 'package:home_hub/models/customer_details_model.dart';
import 'package:home_hub/screens/aaaaborrarservicios.dart';
import 'package:home_hub/screens/ctd_services_screen_detail.dart';
import 'package:home_hub/screens/notification_screen.dart';
import 'package:home_hub/screens/sign_in_screen.dart';

import 'package:home_hub/utils/constant.dart';
import 'package:home_hub/utils/images.dart';
import 'package:home_hub/utils/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../custom_widget/space.dart';
import '../main.dart';
import '../models/customer_review_model.dart';
import '../models/services_model.dart';
import '../screens/all_categories_screen.dart';
import '../screens/auth/screens/SVSignInScreen.dart';
import '../screens/ctd_services_detail_borrar.dart';
import '../screens/ctd_services_screen.dart';
import '../screens/favourite_services_screen.dart';
import '../utils/SVConstants.dart';
import '../utils/colors.dart';
//para consumir el api
import 'package:http/http.dart' as http;

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  double aspectRatio = 0.0;
//-----------
  List<String> bannerList = [home_page1, home_page2, home_page3];

  List<String> _listHomePageCarousel = [
    "Servicios",
    "Sobre nosotros",
    "Instalaciones"
  ];
  String a = "casa";
//-----------

  final offerPagesController =
      PageController(viewportFraction: 0.93, keepPage: true, initialPage: 0);
  final reviewPagesController =
      PageController(viewportFraction: 0.93, keepPage: true, initialPage: 0);

  //-------------------------------
// get api information (aboutUs)
  late Future<List<AboutUs>> _listAboutUs;
  Future<List<AboutUs>> _getAboutUs() async {
    final response = await http.get(Uri.parse(apiUrl + "/sobre-nosotros"));

    List<AboutUs> aboutUs = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jasonData = jsonDecode(body);
      //print(jasonData[3]['descripcion']);
      for (var item in jasonData) {
        aboutUs.add(AboutUs(
            item["nombre"], item["descripcion"], item["multimedia"][0]['url']));
        // print(item["multimedia"][0]['url']);
      }
      // print(aboutUs);
    } else {
      print("Fallo la conexion");
      throw Exception("Falloooo");
    }
    return aboutUs;
  }

  //-------------------------------
  //Carrusel bienvenida

  //-----------------------------------
  @override
  void dispose() {
    offerPagesController.dispose();
    reviewPagesController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _listAboutUs = _getAboutUs();
  }

//Cerrar la cesion en caso de haber sido inicida
  Future<void> _showLogOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '¿Estás seguro de cerrar la sesión?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Si'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparent,
        iconTheme: IconThemeData(size: 30),
        leadingWidth: 200,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('assets/images/logo_app_bar.png'),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          Observer(
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Switch(
                  value: appData.isDark,
                  onChanged: (value) {
                    setState(() {
                      appData.toggle();
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
              color: appData.isDark ? Colors.black : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "B",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: appData.isDark ? Colors.black : whiteColor),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appData.isDark ? whiteColor : Colors.black,
                    ),
                  ),
                  Space(4),
                  Text(
                    getName,
                    style: TextStyle(
                        fontSize: 18,
                        color: appData.isDark ? whiteColor : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Space(4),
                  Text(getEmail, style: TextStyle(color: secondaryColor)),
                ],
              ),
            ),
            drawerWidget(
              drawerTitle: "Mi perfil",
              drawerIcon: Icons.person,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SVSignInScreen()));
                // MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "Servicios",
              drawerIcon: Icons.favorite,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavouriteProvidersScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "Instalaciones",
              drawerIcon: Icons.notifications,
              drawerOnTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "Sobre nosotros",
              drawerIcon: Icons.calendar_month,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BookingsFragment(fromProfile: true)),
                );
              },
            ),
            Expanded(
                child: Divider(
                    thickness: 1.5, color: Colors.grey.withOpacity(0.2))),
            drawerWidget(
              drawerTitle: "Sobre las adicciones",
              drawerIcon: Icons.paid_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Herramientas",
              drawerIcon: Icons.mail,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
                child: Divider(
                    thickness: 1.5, color: Colors.grey.withOpacity(0.2))),
            drawerWidget(
              drawerTitle: "Contactos",
              drawerIcon: Icons.question_mark_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Preguntas frecuentes",
              drawerIcon: Icons.question_mark_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
                child: Divider(
                    thickness: 1.5, color: Colors.grey.withOpacity(0.2))),
            drawerWidget(
              drawerTitle: "Cerrar sesión",
              drawerIcon: Icons.logout,
              drawerOnTap: () {
                Navigator.pop(context);
                _showLogOutDialog();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //BARRA DE BUSQUEDA
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: Form(
            //     child: TextFormField(
            //       keyboardType: TextInputType.name,
            //       style: TextStyle(fontSize: 17),
            //       decoration: commonInputDecoration(
            //         suffixIcon: Icon(Icons.search,
            //             size: 20,
            //             color: appData.isDark ? Colors.white : Colors.black),
            //         hintText: "Search for services",
            //       ),
            //     ),
            //   ),
            // ),

            // Card(
            //   margin: const EdgeInsets.all(20),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       ListTile(
            //         leading: Image(
            //             image: NetworkImage(home_page1), fit: BoxFit.cover),
            //         title: const Text('Demo Title'),
            //         subtitle: const Text('This is a simple card in Flutter.'),
            //       ),
            //     ],
            //   ),
            // ),

            // Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //     child: Text(
            //       'Bienvenido',
            //       textAlign: TextAlign.start,
            //       style: TextStyle(
            //           fontWeight: FontWeight.w900,
            //           fontSize: 18,
            //           color: primaryColor),
            //     )),

            //BIENVENIDA=================================================================
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: title1('Bienvenido')),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: FutureBuilder(
                      future: _listAboutUs,
                      builder:
                          (BuildContext ctx, AsyncSnapshot<List> snapshot) {
                        if (snapshot.hasData) {
                          var value = '';
                          for (var i = 0; i < snapshot.data!.length; i++) {
                            if (snapshot.data![i].name == "Bienvenida") {
                              value = snapshot.data![i].description;
                            }
                          }
                          return paragraphText(value);
                        } else if (snapshot.hasError) {
                          print("Error");
                        }
                        return Center(child: CircularProgressIndicator());
                      })),
            ]),
            Space(16),
            //CARRUSEL BIENVENIDA=========================================================
            SizedBox(
              height: 170,
              child: FutureBuilder(
                  future: _listAboutUs,
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      var valueUrl = "";

                      List imagesUrl = [];
                      List<String> imageDescription = [];

                      for (var i = 0; i < snapshot.data!.length; i++) {
                        valueUrl = apiUrl + snapshot.data![i].multimedia;
                        imagesUrl.add(valueUrl);
                        imageDescription.add(snapshot.data![i].name);
                      }

                      return PageView.builder(
                        controller: offerPagesController,
                        itemCount: imagesUrl.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           ServiceProvidersScreen(
                              //               key: UniqueKey(), index: index)),
//                               // );
// FadeInImage(
//                                                 image: NetworkImage(
//                                                     imagesUrl[index]),
//                                                 fit: BoxFit.cover,
//                                                 placeholder: AssetImage(
//                                                     'assets/icons/loading.gif'))
                            },
                            child: Padding(
                                padding: EdgeInsets.all(6),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(
                                      children: <Widget>[
                                        SizedBox(
                                            width: double.maxFinite,
                                            child: Image.network(
                                              imagesUrl[index],
                                              fit: BoxFit.cover,
                                            )),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.fromLTRB(
                                                      8.0, 8.0, 8.0, 8.0),
                                                  child: Text(
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 18,
                                                        color: whiteColor,
                                                        fontFamily:
                                                            svFontRoboto),
                                                    imageDescription[index],
                                                    maxLines: 5,
                                                    textAlign: TextAlign.center,
                                                  )),
                                            ])
                                      ],
                                    ))),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      print("Error");
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
            //CARRUSEL BIENVENIDA
            // SizedBox(
            //   height: 170,
            //   child: PageView.builder(
            //     controller: offerPagesController,
            //     itemCount: bannerList.length,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => ServiceProvidersScreen(
            //                     key: UniqueKey(), index: index)),
            //           );
            //         },
            //         child: Padding(
            //             padding: EdgeInsets.all(6),
            //             child: ClipRRect(
            //                 borderRadius: BorderRadius.circular(8),
            //                 child: Stack(
            //                   children: <Widget>[
            //                     SizedBox(
            //                         width: double.maxFinite,
            //                         child: FadeInImage(
            //                             image: NetworkImage(bannerList[index]),
            //                             fit: BoxFit.cover,
            //                             placeholder: AssetImage(
            //                                 'assets/icons/loading.gif'))),
            //                     Column(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           Container(
            //                               width: double.infinity,
            //                               //color: Colors.white,
            //                               padding: EdgeInsets.fromLTRB(
            //                                   8.0, 8.0, 8.0, 8.0),
            //                               child: Text(
            //                                 style: TextStyle(
            //                                     fontWeight: FontWeight.w900,
            //                                     fontSize: 18,
            //                                     color: whiteColor,
            //                                     fontFamily: svFontRoboto),
            //                                 _listHomePageCarousel[index],
            //                                 maxLines: 5,
            //                                 textAlign: TextAlign.center,
            //                               )),
            //                         ])
            //                   ],
            //                 ))),
            //       );
            //     },
            //   ),
            // ),
            Space(6),
            SmoothPageIndicator(
              controller: offerPagesController,
              count: 8,
              effect: ExpandingDotsEffect(
                dotHeight: 7,
                dotWidth: 8,
                activeDotColor: appData.isDark ? Colors.white : primaryColor,
                expansionFactor: 2.2,
              ),
            ),
            Space(24),
            //NUESTROS SERVICIOS============================================
            homeTitleWidget(
              titleText: "Nuestros servicios",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // ALL SERVICES
                    builder: (context) => CtdServiceScreen(),
                  ),
                );
              },
            ),
            Space(4),
            //CARRUSEL SERVICIOS============================================
            CtdServicesComponent(),
            homeTitleWidget(
              titleText: "Nuestros servicios",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(
                        list: serviceProviders, fromProviderDetails: false),
                  ),
                );
              },
            ),
            Space(4),
            RenovateHomeComponent(),
            ElevatedButton(
              child: Text("Tap on this"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => CtdServiceScreenDetail(),
                    builder: (context) => TargetPage(da: 'uno'),
                  ),
                );
              },
            ),
            Space(8),
            homeTitleWidget(
              titleText: "Home Services",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(
                        list: serviceProviders, fromProviderDetails: false),
                  ),
                );
              },
            ),
            HomeServiceComponent(),
            Space(16),

            homeTitleWidget(
              titleText: "Home Construction",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(
                        list: serviceProviders, fromProviderDetails: false),
                  ),
                );
              },
            ),
            HomeConstructionComponent(),
            Space(16),
            homeTitleWidget(
              titleText: "Popular Services",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(
                        list: serviceProviders, fromProviderDetails: false),
                  ),
                );
              },
            ),
            Space(4),
            PopularServiceComponent(),

            Space(24),
            homeTitleWidget(
              titleText: "Combos And Subscriptions",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(
                        list: serviceProviders, fromProviderDetails: false),
                  ),
                );
              },
            ),
            Space(4),
            CombosSubscriptionsComponent(),
            Space(32),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "What our customers say",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ),
            ),
            Space(16),
            SizedBox(
              height: 117,
              child: PageView.builder(
                itemCount: customerReviews.length,
                controller: reviewPagesController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CustomerReviewComponent(
                      customerReviewModel: customerReviews[index]);
                },
              ),
            ),
            Space(16),
            SmoothPageIndicator(
              controller: reviewPagesController,
              count: customerReviews.length,
              effect: ScaleEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: appData.isDark ? Colors.white : activeDotColor,
                dotColor: Colors.grey.withOpacity(0.2),
              ),
            ),
            Space(16),
          ],
        ),
      ),
    );
  }
}

// Widget title1(String? titleValue) {
//   return Text(
//     titleValue!,
//     textAlign: TextAlign.start,
//     style: TextStyle(
//         fontWeight: FontWeight.w900, fontSize: 18, color: primaryColor),
//   );
// }

