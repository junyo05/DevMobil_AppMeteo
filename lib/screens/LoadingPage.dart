import 'dart:convert' as convert;

import 'package:appmeteo/models/ville.dart';
import 'package:appmeteo/screens/HomePage.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:appmeteo/utils/constantes.dart';
import 'package:appmeteo/utils/images_constantes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Loadingpage extends StatefulWidget {
  const Loadingpage({super.key});

  @override
  State<Loadingpage> createState() => _LoadingpageState();
}

class _LoadingpageState extends State<Loadingpage> {
  List<String> villes = [
    'Dakar',
    'Thies',
    'Saint-Louis',
    'Ziguinchor',
    'Touba',
  ];

  List<Ville> _villes = [];

  double _progression = 0.0;

  @override
  void initState() {
    super.initState();
    chargerDonnees();
  }

  Future<void> chargerDonnees() async {
    for (int i = 0; i < villes.length; i++) {
      final url = Uri.parse(
        '${Constants.baseUrl}?q=${villes[i]}&appid=${Constants.apiKey}&lang=fr&units=metric',
      );
      final reponse = await http.get(url);

      if (reponse.statusCode == 200) {
        final Map<String, dynamic> donneer = convert.json.decode(reponse.body);

        setState(() {
          _villes.add(Ville.fromJson(donneer));
          _progression = (i + 1) / villes.length;
        });
      } else {
        print("Ca n'a pas marcher tonton : ${reponse.statusCode}");
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage(villeList: _villes)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
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

        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: CircularPercentIndicator(
                radius: 100,
                lineWidth: 10,
                percent: _progression,
                animation: false,
                animateFromLastPercent: true,
                progressColor: themeProvider.isDarkMode
                    ? Colors.blue
                    : Colors.orange,

                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            Lottie.asset(
              themeProvider.isDarkMode
                  ? ImagesConstantes.imMoon
                  : ImagesConstantes.imSunRain,
              width: 200,
              height: 200,
            ),
            Padding(
              padding: EdgeInsets.only(top: 280),
              child: Text(
                'chargement des donnees en cours...',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.grey : Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
