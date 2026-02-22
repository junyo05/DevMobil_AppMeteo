import 'package:appmeteo/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Accueilapp extends StatelessWidget {
  const Accueilapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 0, 6, 58),
              const Color.fromARGB(255, 65, 29, 0),
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
                color: const Color.fromARGB(255, 0, 11, 20),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 1, 34),
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
                        color: Colors.white,
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
                        color: Colors.blue,
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
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                // minimumSize: Size(double.infinity, 55),
                fixedSize: Size(300, 60),
                elevation: 10,
                shadowColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_right_alt, size: 30, color: Colors.black),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                'Examen Dev Mobile - made by JAA-ISI',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
