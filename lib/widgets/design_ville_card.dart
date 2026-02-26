import 'package:appmeteo/models/ville.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:weather_icons/weather_icons.dart';

class DesignVilleCard extends StatelessWidget {
  final Ville ville;

  const DesignVilleCard({super.key, required this.ville});

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

    return Icon(weatherIcon, size: 50, color: Colors.blue.withOpacity(0.5));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          '/details',
          arguments: {'ville': ville},
        );
      },
      child: Container(
        height: 180,
        width: double.infinity,
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode
              ? const Color.fromARGB(255, 0, 12, 66)
              : const Color.fromARGB(255, 212, 214, 224),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CountryFlag.fromCountryCode(
                          ville.pays,
                          theme: EmojiTheme(size: 20),
                        ),
                        SizedBox(width: 2),
                        Text(
                          ville.nom,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(height: 5),
                        Text(ville.description, textAlign: TextAlign.left),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 50, child: getIconWidget(ville.icone)),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 5,
                            bottom: 5,
                          ),
                          child: Text(
                            '${ville.temperature}°C',
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 30),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      WeatherIcons.humidity,
                      color: themeProvider.isDarkMode
                          ? Colors.blue
                          : Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2, right: 15),
                      child: Text(
                        '${ville.humidite}%',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 18,
                      child: Icon(
                        WeatherIcons.wind_beaufort_0,
                        color: themeProvider.isDarkMode
                            ? Colors.blue
                            : Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4, right: 15),
                      child: Text(
                        '${ville.vitesseVent}km/h',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      color: themeProvider.isDarkMode
                          ? Colors.blue
                          : Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2, right: 15),
                      child: Text(
                        '${ville.visibilite}km',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'voir les details',
                    style: TextStyle(
                      fontSize: 12,
                      color: themeProvider.isDarkMode
                          ? Colors.blue
                          : Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 10,
                  child: Icon(
                    Icons.arrow_right_alt,
                    size: 18,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
