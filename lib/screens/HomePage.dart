import 'package:appmeteo/screens/AccueilApp.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: const Color.fromARGB(255, 1, 7, 46),
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Accueilapp()),
          );
        },
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 90),
      ),
    );
  }
}
