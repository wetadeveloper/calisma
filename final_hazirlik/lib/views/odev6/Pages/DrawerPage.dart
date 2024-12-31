import 'package:final_hazirlik/models/odev6_users.dart';
import 'package:final_hazirlik/views/odev6/Pages/Anasayfa.dart';
import 'package:final_hazirlik/views/odev6/Pages/Ayarlar.dart';
import 'package:final_hazirlik/views/odev6/Pages/GelirGider.dart';
import 'package:final_hazirlik/views/odev6/Pages/Hesaplama.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  late Users user;

  DrawerPage(this.user);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  var sayfaListesi;
  var secilenIndeks = 0;

  @override
  void initState() {
    super.initState();
    sayfaListesi = [
      Anasayfa(widget.user),
      GelirGider(widget.user.userID),
      Hesaplama(widget.user.userID),
      Ayarlar(widget.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.white,
        ),
        body: sayfaListesi[secilenIndeks],
        drawer: Drawer(
          backgroundColor: Colors.lightBlueAccent,
          child: ListView(
            children: [
              const DrawerHeader(
                  child: Text("Sayfalar",
                      style: TextStyle(fontSize: 40, color: Colors.white))),
              ListTile(
                title: const Text(
                  "Anasayfa",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                leading: const Icon(
                  Icons.home_outlined,
                  size: 30,
                  color: Colors.black38,
                ),
                onTap: () {
                  setState(() {
                    secilenIndeks = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "Gelir-Gider Girisi",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                leading: const Icon(
                  Icons.monetization_on_outlined,
                  size: 30,
                  color: Colors.black38,
                ),
                onTap: () {
                  setState(() {
                    secilenIndeks = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "Gelir-Gider Hesaplama",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                leading: const Icon(
                  Icons.calculate_outlined,
                  size: 30,
                  color: Colors.black38,
                ),
                onTap: () {
                  setState(() {
                    secilenIndeks = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "Ayarlar",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                leading: const Icon(
                  Icons.settings_outlined,
                  size: 30,
                  color: Colors.black38,
                ),
                onTap: () {
                  setState(() {
                    secilenIndeks = 3;
                  });
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }
}
