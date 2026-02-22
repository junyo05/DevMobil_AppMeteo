import 'package:appmeteo/screens/AccueilApp.dart';
import 'package:appmeteo/themes/themes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
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
    );
  }
}
