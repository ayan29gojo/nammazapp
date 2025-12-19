import 'package:flutter/material.dart';
import 'package:untitled75/Screens/addnamaz_screen.dart';
import 'package:untitled75/Screens/viewnamaz_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Namaz Tracker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddNamazScreen()),
                );
              },
              child: const Text('Add Namaz'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ViewNamazScreen()),
                );
              },
              child: const Text('View Records'),
            ),
          ],
        ),
      ),
    );
  }
}

