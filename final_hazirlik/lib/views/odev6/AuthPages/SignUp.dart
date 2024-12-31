import 'dart:io';
import 'package:final_hazirlik/services/odev6_services.dart';
import 'package:final_hazirlik/views/odev6/AuthPages/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var selectedImage = null;
  var key = GlobalKey<FormState>();
  var uName = TextEditingController();
  var pasw1 = TextEditingController();
  var pasw2 = TextEditingController();

  Future<void> getImageGallery() async {
    var selectedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
        title: const Text("Sign-Up"),
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
                    ? SizedBox(width: 100, child: Image.file(selectedImage))
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
                  controller: pasw1,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                  validator: (input) {
                    if (input != null) {
                      if (input.isEmpty) {
                        return "Lutfen Sifrenizi giriniz!";
                      }
                      if (input.length < 2) {
                        return "Guclu bir sifre girin";
                      }
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: pasw2,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Parola Tekrar"),
                  validator: (input) {
                    if (input != null) {
                      if (input.length < 3) {
                        return "Guclu bir sifre girin";
                      }
                      if (input.isEmpty || pasw1.text != pasw2.text) {
                        return "Yazdığınız parolalar eşleşmiyor!";
                      }
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        var userName = uName.text;
                        var passw = pasw2.text;
                        var imagePath = selectedImage?.path;
                        await Services().ekle(userName, passw, imagePath);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
                      }
                    },
                    child: const Text("Sign-Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
