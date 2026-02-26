import 'package:intl/intl.dart';

class Ville {
  final String nom;
  final double temperature;
  final String description;
  final String icone;
  final int humidite; // main.humidity
  final double vitesseVent; // wind.speed
  final int pression; // main.pressure
  final int visibilite; // visibility
  final int nuages; // clouds.all
  final double ressenti; // main.feels_like
  final int leverSoleil; // sys.sunrise
  final int coucherSoleil; // sys.sunset
  final String pays;
  final double latitude; // coord.lat
  final double longitude; // coord.lon
  final int date;

  Ville({
    required this.nom,
    required this.temperature,
    required this.description,
    required this.icone,
    required this.humidite,
    required this.vitesseVent,
    required this.pression,
    required this.visibilite,
    required this.nuages,
    required this.ressenti,
    required this.leverSoleil,
    required this.coucherSoleil,
    required this.pays,
    required this.latitude,
    required this.longitude,
    required this.date,
  });

  factory Ville.fromJson(Map<String, dynamic> json) {
    return Ville(
      nom: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icone: json['weather'][0]['icon'],
      humidite: json['main']['humidity'],
      vitesseVent: json['wind']['speed'].toDouble(),
      pression: json['main']['pressure'],
      visibilite: json['visibility'],
      nuages: json['clouds']['all'],
      ressenti: json['main']['feels_like'].toDouble(),
      leverSoleil: json['sys']['sunrise'],
      coucherSoleil: json['sys']['sunset'],
      pays: json['sys']['country'],
      latitude: json['coord']['lat'].toDouble(),
      longitude: json['coord']['lon'].toDouble(),
      date: json['dt'],
    );
  }
  String get dateFormatee {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    return DateFormat('EEEE dd MMMM yyyy', 'fr').format(dateTime);
  }
}
