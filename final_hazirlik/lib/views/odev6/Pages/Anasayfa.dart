import 'package:final_hazirlik/models/odev6_users.dart';
import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  late Users user;

  Anasayfa(this.user);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

//burasi eklenmezse vsync: this hata verir -> TickerProviderStateMixin
class _AnasayfaState extends State<Anasayfa> with TickerProviderStateMixin {
  var selectedImage = null;
  late AnimationController animationController;
  late Animation<double> degerler1;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    degerler1 = Tween(begin: 100.0, end: 200.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Hosgeldiniz",
              style: TextStyle(
                  fontSize: 30, fontStyle: FontStyle.italic, color: Colors.red),
            ),
            widget.user.imageFile != null
                ? GestureDetector(
                onTap: () {
                  if (animationController.status ==
                      AnimationStatus.completed) {
                    animationController.reverse();
                  } else if (animationController.status ==
                      AnimationStatus.dismissed) {
                    animationController.forward();
                  }
                },
                child: Opacity(
                    opacity: 1.0,
                    child: SizedBox(
                      width: degerler1.value,
                      child: Image.file(widget.user.imageFile!),
                    )))
                : GestureDetector(
                    onTap: () {
                      if (animationController.status ==
                          AnimationStatus.completed) {
                        animationController.reverse();
                      } else if (animationController.status ==
                          AnimationStatus.dismissed) {
                        animationController.forward();
                      }
                    },
                    child: Opacity(
                        opacity: 1.0,
                        child: SizedBox(
                          width: degerler1.value,
                          child: ClipOval(
                              child: Icon(Icons.person_pin_sharp,
                                  size: degerler1.value)),
                        ))),
          ],
        ),
      ),
    );
  }
}
