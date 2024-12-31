import 'package:final_hazirlik/models/odev6_harcamalar.dart';
import 'package:final_hazirlik/services/odev6_services.dart';
import 'package:flutter/material.dart';


class HesaplamaDetay extends StatefulWidget {
  Harcamalar harcama;

  HesaplamaDetay(this.harcama);

  @override
  State<HesaplamaDetay> createState() => _HesaplamaDetayState();
}

class _HesaplamaDetayState extends State<HesaplamaDetay> {
  var takvimController = TextEditingController();
  var gelirController = TextEditingController();
  var gelirAciklamaController = TextEditingController();
  var giderController = TextEditingController();
  var giderAciklamaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    takvimController.text = widget.harcama.tarih;
    gelirController.text = "${widget.harcama.gelir}";
    gelirAciklamaController.text = widget.harcama.gelirAciklama;
    giderController.text = "${widget.harcama.gider}";
    giderAciklamaController.text = widget.harcama.giderAciklama;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () async {
                await Services().insertOrUpdateGelirGider(
                    harcamaID: widget.harcama.harcamaID,
                    widget.harcama.userID,
                    takvimController.text,
                    double.parse(gelirController.text),
                    double.parse(giderController.text),
                    gelirAciklamaController.text,
                    giderAciklamaController.text);
                Navigator.pop(context);
              },
              child: const Text("Guncelle",style: const TextStyle(color: Colors.white,fontSize: 20),)),
        ],
      ),
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
                prefixIcon: Icon(Icons.calendar_today,),
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
    );
  }
}
