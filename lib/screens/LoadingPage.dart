import 'dart:async';

import 'package:appmeteo/models/ville.dart';
import 'package:appmeteo/services/meteo_services.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:appmeteo/utils/images_constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:appmeteo/utils/messagesDynamique.dart';

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
    'Kaolack',
  ];

  final MeteoService _meteoService = MeteoService();

  Timer? _timer;
  int _messageIndex = 0;
  final List<String> _messages = MessagesDynamique.messages;

  List<Ville> _villes = [];

  double _progression = 0.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        if (_messageIndex < _messages.length - 1) {
          _messageIndex++;
        } else {
          _timer?.cancel();
        }
      });
    });
    chargerDonnees();
  }

  Future<void> _animerProgression(double cible) async {
    while (_progression < cible) {
      await Future.delayed(Duration(milliseconds: 50));
      setState(() {
        _progression += 0.01;
        if (_progression > cible) _progression = cible;
      });
    }
  }

  Future<void> chargerDonnees() async {
    for (int i = 0; i < villes.length; i++) {
      try {
        final ville = await _meteoService.getVille(villes[i]);
        setState(() {
          _villes.add(ville);
        });
        _animerProgression((i + 1) / villes.length);
        await Future.delayed(Duration(seconds: 1));
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erreur'),
            content: Text('Impossible de charger les données météo.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  chargerDonnees();
                },
                child: Text('Réessayer'),
              ),
            ],
          ),
        );
      }
    }

    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {'villeList': _villes, 'ville': _villes[0]},
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                MessagesDynamique.messages[_messageIndex],
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
