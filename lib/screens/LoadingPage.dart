import 'package:appmeteo/screens/HomePage.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:appmeteo/utils/images_constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class Loadingpage extends StatefulWidget {
  const Loadingpage({super.key});

  @override
  State<Loadingpage> createState() => _LoadingpageState();
}

class _LoadingpageState extends State<Loadingpage> {
  @override
  void initState() {
    super.initState();
    chargerDonnees();
  }

  Future<void> chargerDonnees() async {
    await Future.delayed(Duration(seconds: 4));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: themeProvider.isDarkMode
                ? [
                    const Color.fromARGB(255, 0, 6, 58),
                    const Color.fromARGB(255, 65, 29, 0),
                  ]
                : [
                    const Color.fromARGB(255, 236, 230, 230),
                    const Color.fromARGB(255, 233, 219, 90),
                  ],
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: themeProvider.isDarkMode
                      ? Colors.blue.withOpacity(0.3)
                      : Colors.orange.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Lottie.asset(
              themeProvider.isDarkMode
                  ? ImagesConstantes.imMoon
                  : ImagesConstantes.imSunRain,
              width: 300,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
