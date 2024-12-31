import 'package:final_hazirlik/services/odev6_services.dart';
import 'package:final_hazirlik/views/odev6/AuthPages/SignUp.dart';
import 'package:final_hazirlik/views/odev6/Pages/DrawerPage.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var key = GlobalKey<FormState>();
  var uName = TextEditingController();
  var pasw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        title: const Text("Sign-In"),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    if (input.length < 3) {
                      return "Guclu bir sifre girin";
                    }
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent, foregroundColor: Colors.white),
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          var user = await Services().kullaniciVerisiGetir(uName.text, pasw.text);
                          if (user != null) {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => DrawerPage(user)));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Kullanici Bulunamadi")));
                          }
                        }
                        //controllerTextleri sqflite'tan kontrol et
                      },
                      child: const Text("Sign-In")),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUp()));
                  },
                  child: const Text(
                    "Sign-Up",
                    style: TextStyle(color: Colors.deepOrange),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
