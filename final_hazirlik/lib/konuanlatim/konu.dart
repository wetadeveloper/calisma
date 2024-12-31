// Shared Preferences, Path Provider ve Animasyon İşlemleri

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> with SingleTickerProviderStateMixin {
  // Shared Preferences Örneği
  String _savedData = 'Henüz veri kaydedilmedi';

  Future<void> _saveData(String data) async {
    // Shared Preferences ile veri kaydetme işlemi
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('myKey', data);
    setState(() {
      _savedData = data;
    });
  }

  Future<void> _loadData() async {
    // Shared Preferences ile veri okuma işlemi
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedData = prefs.getString('myKey') ?? 'Veri bulunamadı';
    });
  }

  // Path Provider Örneği
  String _fileContent = 'Dosya içeriği burada görünecek';

  Future<void> _writeFile(String data) async {
    // Belirli bir dosya yolunu almak için path_provider kullanılıyor
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/example.txt');
    await file.writeAsString(data);
  }

  Future<void> _readFile() async {
    // Dosyayı okumak için path_provider kullanılıyor
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/example.txt');
      String content = await file.readAsString();
      setState(() {
        _fileContent = content;
      });
    } catch (e) {
      setState(() {
        _fileContent = 'Dosya okuma hatası';
      });
    }
  }

  // Animasyon Örneği
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Animasyon kontrolcüsü ve animasyon tanımlanıyor
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 300).animate(_controller)
      ..addListener(() {
        // Her animasyon karesinde widget yeniden çiziliyor
        setState(() {});
      });

    // Animasyon başlatılıyor
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Kaynak sızıntılarını önlemek için kontrolcü serbest bırakılıyor
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Kullanıcıdan alınan dinamik liste
    List<String> dynamicList = ['Öğe 1', 'Öğe 2', 'Öğe 3', 'Öğe 4'];

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Örnekleri')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Shared Preferences
            Text('Shared Preferences: $_savedData'),
            ElevatedButton(
              onPressed: () => _saveData('Merhaba, Flutter!'),
              child: const Text('Veri Kaydet'),
            ),
            ElevatedButton(
              onPressed: _loadData,
              child: const Text('Veri Yükle'),
            ),
            const SizedBox(height: 20),

            // Path Provider
            Text('Path Provider: $_fileContent'),
            ElevatedButton(
              onPressed: () => _writeFile('Bu bir dosya örneğidir.'),
              child: const Text('Dosyaya Yaz'),
            ),
            ElevatedButton(
              onPressed: _readFile,
              child: const Text('Dosyadan Oku'),
            ),
            const SizedBox(height: 20),

            // Animasyon
            const Text('Animasyon Örneği:'),
            Container(
              width: _animation.value,
              height: 50,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),

            // ListTile Örneği
            const Text('ListTile Örneği:'),
            ListTile(
              // ListTile, bir satırda başlık, alt başlık, simge gibi bilgileri göstermek için kullanılır.
              leading: const Icon(Icons.account_circle), // Sol tarafta gösterilen simge
              title: const Text('Başlık'), // Ana metin
              subtitle: const Text('Alt Başlık'), // Alt metin
              trailing: const Icon(Icons.arrow_forward), // Sağ tarafta gösterilen simge
              onTap: () {
                // Tıklandığında bir işlem yapmak için kullanılan fonksiyon
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ListTile Tıklandı!')),
                );
              },
            ),
            const SizedBox(height: 20),

            // ListView ile ListTile Kullanımı - Dinamik Eleman Sayısı
            const Text('ListView ile Dinamik ListTile Örneği (Length Tabanlı):'),
            ListView.builder(
              shrinkWrap: true, // ListView'in Column içinde düzgün çalışması için
              physics: const NeverScrollableScrollPhysics(), // Scroll çatışmasını önlemek için
              itemCount: dynamicList.length, // Dinamik liste eleman sayısı
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(dynamicList[index]), // Dinamik olarak liste öğesi
                  subtitle: Text('${dynamicList[index]} alt başlığı.'),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${dynamicList[index]} tıklandı!')),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),

            // ListView ile ListTile Kullanımı - Kullanıcı Belirlemeli Sayı
            const Text('ListView ile ListTile Örneği (Sayı Girerek):'),
            ListView.builder(
              shrinkWrap: true, // ListView'in Column içinde düzgün çalışması için
              physics: const NeverScrollableScrollPhysics(), // Scroll çatışmasını önlemek için
              itemCount: 5, // Sabit bir sayı ile belirlenen liste elemanları
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.circle),
                  title: Text('Sabit Eleman $index'),
                  subtitle: Text('Bu sabit eleman $index için alt başlık.'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sabit Eleman $index tıklandı!')),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
