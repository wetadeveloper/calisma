import 'package:final_hazirlik/services/odev6_services.dart';
import 'package:flutter/material.dart';

class GelirGider extends StatefulWidget {
  int userID;

  GelirGider(this.userID);

  @override
  State<GelirGider> createState() => _GelirGiderState();
}

class _GelirGiderState extends State<GelirGider> {
  var takvimController = TextEditingController();
  var gelirController = TextEditingController();
  var gelirAciklamaController = TextEditingController();
  var giderController = TextEditingController();
  var giderAciklamaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: takvimController,
              decoration: const InputDecoration(
                labelText: "Takvim",
                prefixIcon: Icon(Icons.calendar_today),
                filled: true,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              ),
              readOnly: true,
              onTap: () async{
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050)
                );
                if(date != null){
                  setState(() {
                    takvimController.text = date.toString().split(" ")[0];
                  });
                }

              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: gelirController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Gelir"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: gelirAciklamaController,
                      maxLines: 5,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(labelText: "Aciklama"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: giderController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Gider"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: giderAciklamaController,
                      maxLines: 5,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(labelText: "Aciklama"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Services().insertOrUpdateGelirGider(
              widget.userID,
              takvimController.text,
              double.parse(gelirController.text),
              double.parse(giderController.text),
              gelirAciklamaController.text,
              giderAciklamaController.text);
        },
        icon: const Icon(Icons.save_outlined),
        label: const Text("Kaydet"),
      ),
    );
  }
}
