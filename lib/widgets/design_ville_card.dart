import 'package:appmeteo/models/ville.dart';
import 'package:appmeteo/screens/DetailsPage.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_flags/country_flags.dart';

class DesignVilleCard extends StatelessWidget {
  final Ville ville;

  const DesignVilleCard({super.key, required this.ville});

  Color getIconColor(String icone) {
    if (icone.contains('01d')) return Colors.yellow; // soleil jour
    if (icone.contains('01n'))
      return const Color.fromARGB(255, 179, 172, 172); // lune nuit
    if (icone.contains('02')) return Colors.orange;
    if (icone.contains('03') || icone.contains('04')) return Colors.white;
    if (icone.contains('09') || icone.contains('10')) return Colors.blue;
    if (icone.contains('11')) return Colors.purple;
    if (icone.contains('50')) return Colors.blueGrey; // brume
    return Colors.yellow;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detailspage(ville: ville)),
        );
      },
      child: Container(
        height: 180,
        width: double.infinity,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode
              ? const Color.fromARGB(255, 0, 12, 66)
              : const Color.fromARGB(255, 212, 214, 224),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        CountryFlag.fromCountryCode(
                          'SN',
                          theme: EmojiTheme(size: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            ville.nom,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(ville.description, textAlign: TextAlign.left),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          'https://openweathermap.org/img/wn/${ville.icone}@2x.png',
                          height: 70,
                          width: 70,
                          color: getIconColor(ville.icone),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
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
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.water,
                      color: themeProvider.isDarkMode
                          ? Colors.blue
                          : Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
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
                    Icon(
                      Icons.wind_power,
                      color: themeProvider.isDarkMode
                          ? Colors.blue
                          : Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
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
                      padding: EdgeInsets.only(left: 5, right: 10),
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
                Icon(Icons.arrow_right, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
