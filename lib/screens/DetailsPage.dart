import 'package:appmeteo/models/ville.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:appmeteo/widgets/design_details_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Detailspage extends StatelessWidget {
  final Ville ville;
  const Detailspage({super.key, required this.ville});

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
            Navigator.pushNamed(context, '/loading');
          },
        ),
        title: Text(
          ville.nom,
          style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
      body: DesignDetailsCard(ville: ville),
    );
  }
}
