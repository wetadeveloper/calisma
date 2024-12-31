import 'package:final_hazirlik/konuanlatim/konu.dart';
import 'package:final_hazirlik/views/notesapp/notesapp.dart';
import 'package:final_hazirlik/views/odev6/AuthPages/SignIn.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Notesapp()));
              },
              child: const Text("Not Defteri")),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: const Text("Odev 6 Giriş")),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ExamplePage()));
              },
              child: const Text("Konu Anlatımı")),
        ],
      ),
    );
  }
}
