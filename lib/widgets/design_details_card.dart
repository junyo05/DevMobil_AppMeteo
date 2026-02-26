import 'dart:ui';

import 'package:appmeteo/models/ville.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_icons/weather_icons.dart';

class DesignDetailsCard extends StatelessWidget {
  final Ville ville;
  const DesignDetailsCard({super.key, required this.ville});

  String convertirTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget getIconWidget(String icone) {
    IconData weatherIcon;

    if (icone.contains('01d'))
      weatherIcon = WeatherIcons.day_sunny;
    else if (icone.contains('01n'))
      weatherIcon = WeatherIcons.moon_alt_new;
    else if (icone.contains('02d'))
      weatherIcon = WeatherIcons.day_cloudy;
    else if (icone.contains('02n'))
      weatherIcon = WeatherIcons.night_cloudy;
    else if (icone.contains('03'))
      weatherIcon = WeatherIcons.cloud;
    else if (icone.contains('04'))
      weatherIcon = WeatherIcons.cloudy;
    else if (icone.contains('09'))
      weatherIcon = WeatherIcons.showers;
    else if (icone.contains('10d'))
      weatherIcon = WeatherIcons.day_rain;
    else if (icone.contains('10n'))
      weatherIcon = WeatherIcons.night_rain;
    else if (icone.contains('11'))
      weatherIcon = WeatherIcons.thunderstorm;
    else if (icone.contains('13'))
      weatherIcon = WeatherIcons.snow;
    else if (icone.contains('50'))
      weatherIcon = WeatherIcons.fog;
    else
      weatherIcon = WeatherIcons.day_sunny;

    return Icon(weatherIcon, size: 50, color: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Container(
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

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(top: 20, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeProvider.isDarkMode
                    ? const Color.fromARGB(255, 22, 26, 49)
                    : Colors.blueGrey,
              ),

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Center(
                        child: CountryFlag.fromCountryCode(
                          ville.pays,
                          theme: EmojiTheme(size: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 0),
                        child: Text(
                          ville.nom,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1),
                  Text(
                    ville.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: themeProvider.isDarkMode
                          ? Colors.grey
                          : Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getIconWidget(ville.icone),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 5,
                          bottom: 5,
                          top: 5,
                        ),
                        child: Text(
                          '${ville.temperature}°C',
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Ressenti ${ville.ressenti}°C',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.grey
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                Container(
                  height: 140,
                  width: 100,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 22, 26, 49)
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(WeatherIcons.humidity, size: 30, color: Colors.blue),
                      SizedBox(height: 10),
                      Text(
                        'Humidite',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                      Text(
                        '${ville.humidite} %',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  width: 100,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 22, 26, 49)
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        WeatherIcons.day_windy,
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Vent',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                      Text(
                        '${ville.vitesseVent} km',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  width: 100,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 22, 26, 49)
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        WeatherIcons.barometer,
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Pression',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                      Text(
                        '${ville.pression} hPa',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  width: 100,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 22, 26, 49)
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.visibility, size: 30, color: Colors.blue),
                      SizedBox(height: 10),
                      Text(
                        'vilibite',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                      Text(
                        '${ville.visibilite} km',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  width: 100,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 22, 26, 49)
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(WeatherIcons.cloud, size: 30, color: Colors.blue),
                      SizedBox(height: 10),
                      Text(
                        'Nuages',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                      Text(
                        '${ville.nuages} %',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  width: 100,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 22, 26, 49)
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        WeatherIcons.thermometer,
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Resenti',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                      Text(
                        '${ville.ressenti} °C',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 5,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 170,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 22, 26, 49)
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            WeatherIcons.sunrise,
                            size: 30,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'lever du soleil',
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                              ),
                              Text(
                                convertirTimestamp(ville.coucherSoleil),
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: 170,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 22, 26, 49)
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            WeatherIcons.sunset,
                            size: 30,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'lever du soleil',
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                              ),
                              Text(
                                convertirTimestamp(ville.leverSoleil),
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 250,
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    // La carte en dessous
                    FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(ville.latitude, ville.longitude),
                        initialZoom: 12,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                          userAgentPackageName: 'com.example.appmeteo',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(ville.latitude, ville.longitude),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Le bandeau en haut par dessus la carte
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        color: Colors.black.withOpacity(0.6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Localisation',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${ville.latitude}, ${ville.longitude}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(MediaQuery.of(context).size.width - 30, 60),
                  elevation: 10,
                  shadowColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  print('Bouton cliquer');
                  final url = Uri.parse(
                    'https://maps.google.com/?q=${ville.latitude},${ville.longitude}',
                  );
                  print('url: $url');
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 25,
                      color: themeProvider.isDarkMode
                          ? Colors.black
                          : Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Ouvrir avec google map',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.open_in_new,
                      size: 25,
                      color: themeProvider.isDarkMode
                          ? Colors.black
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
