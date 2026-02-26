import 'package:appmeteo/screens/AccueilApp.dart';
import 'package:appmeteo/screens/DetailsPage.dart';
import 'package:appmeteo/screens/HomePage.dart';
import 'package:appmeteo/screens/LoadingPage.dart';
import 'package:flutter/material.dart';

class Redirections {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              Homepage(villeList: args['villeList'], ville: args['ville']),
        );
      case '/AccueilApp':
        return MaterialPageRoute(builder: (_) => Accueilapp());

      case '/details':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => Detailspage(ville: args['ville']),
        );
      case '/loadgin':
      default:
        return MaterialPageRoute(builder: (_) => Loadingpage());
    }
  }
}
