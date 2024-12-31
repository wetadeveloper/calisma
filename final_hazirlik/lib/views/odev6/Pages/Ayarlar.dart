import 'dart:io';
import 'package:final_hazirlik/models/odev6_users.dart';
import 'package:final_hazirlik/services/odev6_services.dart';
import 'package:final_hazirlik/views/odev6/AuthPages/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Ayarlar extends StatefulWidget {
  Users user;

  Ayarlar(this.user);

  @override
  State<Ayarlar> createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  var selectedImage = null;
  var key = GlobalKey<FormState>();
  var uName = TextEditingController();
  var pasw = TextEditingController();

  @override
  void initState() {
    super.initState();
    var user = widget.user;
    selectedImage = user.imageFile;
    uName.text = user.userName;
    pasw.text = user.password;
  }

  Future<void> getImageGallery() async {
    var selectedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedFile != null) {
      setState(() {
        selectedImage = File(selectedFile.path);
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SignIn()));
              },
              icon: const Icon(
                Icons.exit_to_app_outlined,
                size: 50,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                selectedImage != null
                    ? SizedBox(
                  width: 200,
                  child: GestureDetector(
                          onTap: () {
                            getImageGallery();
                          },
                          child: Image.file(selectedImage)),
                    )
                    : GestureDetector(
                        onTap: () {
                          getImageGallery();
                        },
                        child: const Icon(Icons.person)),
                TextFormField(
                  controller: uName,
                  decoration: const InputDecoration(labelText: "UserName"),
                  validator: (input) {
                    if (input != null) {
                      if (input.isEmpty) {
                        return "Lutfen Kullanici Adi giriniz!";
                      }
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: pasw,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                  validator: (input) {
                    if (input != null) {
                      if (input.isEmpty) {
                        return "Lutfen Sifrenizi giriniz!";
                      }
                      if (input.length < 6) {
                        return "Guclu bir sifre girin";
                      }
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          var imagePath = selectedImage?.path;
          Services()
              .guncelle(widget.user.userID, uName.text, pasw.text, imagePath);
        },
        icon: Icon(Icons.update_outlined),
        label: Text("Guncelle"),
      ),
    );
  }
}
