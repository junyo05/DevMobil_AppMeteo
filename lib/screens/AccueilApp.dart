import 'package:appmeteo/screens/HomePage.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Accueilapp extends StatelessWidget {
  const Accueilapp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Text(
            'Theme',
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.toggleTheme(),

            thumbIcon: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Icon(Icons.dark_mode, color: Colors.white);
              }
              return Icon(Icons.light_mode, color: Colors.orange);
            }),
            activeColor: Colors.indigo,
            inactiveThumbColor: Colors.orange,
            inactiveTrackColor: Colors.orange.withOpacity(0.3),
          ),
        ],
      ),
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

        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Container(
              height: 100,
              width: 120,
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: themeProvider.isDarkMode ? Colors.black : Colors.white,
                  width: 2,
                ),
              ),

              child: Stack(
                children: [
                  Center(
                    child: FaIcon(
                      FontAwesomeIcons.cloudSun,
                      size: 60,
                      color: Colors.blue,
                    ),
                  ),

                  Positioned(
                    bottom: -5,
                    right: -2,
                    child: Opacity(
                      opacity: 0.5,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color.fromARGB(255, 212, 130, 6),
                          color: Colors.orange,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.compass,
                          color: Colors.orange,
                          size: 30,
                        ),
                      ),
                    ),
                    // child: FaIcon(
                    //   FontAwesomeIcons.compass,
                    //   color: Colors.orange,
                    // ),
                  ),
                ],
              ),
            ),

            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'App Meteo',
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'Votre compagnon meteo intello',
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.blue
                            : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: 10,
                      bottom: 10,
                      right: 10,
                    ),
                    child: Text(
                      'Explorez la meteo en temps reel pour 5 grandes villes dans un monde\n Donnees actualiser, cartes interactives et plus encore.',
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.grey
                            : const Color.fromARGB(255, 76, 105, 167),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: Size(300, 60),
                elevation: 10,
                shadowColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      'Lancer l\'experience',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: themeProvider.isDarkMode
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    size: 30,
                    color: themeProvider.isDarkMode
                        ? Colors.black
                        : Colors.white,
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                'Examen Dev Mobile - made by JAA-ISI',
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? Colors.grey
                      : const Color.fromARGB(255, 76, 105, 167),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
