import 'package:appmeteo/models/ville.dart';
import 'package:appmeteo/screens/AccueilApp.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:appmeteo/widgets/design_ville_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  final List<Ville> villeList;
  final Ville ville;

  const Homepage({super.key, required this.villeList, required this.ville});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Accueilapp()),
            );
          },
        ),
        backgroundColor: themeProvider.isDarkMode
            ? const Color.fromARGB(255, 0, 1, 51)
            : const Color.fromARGB(255, 226, 224, 216),
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
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
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
        width: double.infinity,
        height: double.infinity,
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

        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Meteo ${widget.ville.pays}',
                              style: TextStyle(
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Column(children: [Text(widget.ville.dateFormatee)]),
                        Container(
                          height: 30,
                          width: 80,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '5 Villes',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.location_city,
                                size: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    DesignVilleCard(ville: widget.villeList[index]),
                childCount: widget.villeList.length,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 40,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 1, 14, 56)
                        : Colors.white,
                    fixedSize: Size(MediaQuery.of(context).size.width - 30, 60),
                    elevation: 10,
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/loading');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh_sharp, size: 22, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Recharger les donnees',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.blue
                              : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
