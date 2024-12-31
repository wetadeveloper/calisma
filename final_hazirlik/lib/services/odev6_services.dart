import 'dart:io';

import 'package:final_hazirlik/models/odev6_harcamalar.dart';
import 'package:final_hazirlik/models/odev6_users.dart';
import 'package:final_hazirlik/services/odev6_database_helper.dart';

class Services {
  Future<void> ekle(String userName, String password, String? imagePath) async {
    var db = await DatabaseHelper().veritabaniErisim();
    var info = Map<String, dynamic>();
    info["userName"] = userName;
    info["password"] = password;
    info["imageFile"] = imagePath;
    await db.insert("users", info);
  }

  Future<void> guncelle(int userID, String userName, String password, String? imagePath) async {
    var db = await DatabaseHelper().veritabaniErisim();
    var info = Map<String, dynamic>();
    info["userName"] = userName;
    info["password"] = password;
    info["imageFile"] = imagePath;
    await db.update("users", info, where: "userID=?", whereArgs: [userID]);
  }

  Future<void> sil(int userID) async {
    var db = await DatabaseHelper().veritabaniErisim();
    await db.delete("users", where: "userID = ?", whereArgs: [userID]);
  }

  Future<void> insertOrUpdateGelirGider(
      int userID, String tarih, double gelir, double gider, String gelirAciklama, String giderAciklama,
      {int? harcamaID}) async {
    try {
      var db = await DatabaseHelper().veritabaniErisim();

      var result = await db.query(
        'gelir_gider',
        where: 'userID = ? AND tarih = ?',
        whereArgs: [userID, tarih],
      );

      if (result.isNotEmpty) {
        if (harcamaID != null) {
          var info = Map<String, dynamic>();
          info["userID"] = userID;
          info["tarih"] = tarih;
          info["gelir"] = gelir;
          info["gelirAciklama"] = gelirAciklama;
          info["gider"] = gider;
          info["giderAciklama"] = giderAciklama;
          await db.update(
            'gelir_gider',
            info,
            where: 'harcamaID = ? AND tarih = ?',
            whereArgs: [harcamaID, tarih],
          );
        }
      } else {
        var info = Map<String, dynamic>();
        info["userID"] = userID;
        info["tarih"] = tarih;
        info["gelir"] = gelir;
        info["gelirAciklama"] = gelirAciklama;
        info["gider"] = gider;
        info["giderAciklama"] = giderAciklama;
        await db.insert('gelir_gider', info);
      }
    } catch (e) {
      print("Error in insertOrUpdateGelirGider: $e");
    }
  }

  Future<List<Harcamalar>> getGelirGiderByUserID(int userID) async {
    var db = await DatabaseHelper().veritabaniErisim();
    var maps = await db.query('gelir_gider', where: 'userID = ?', whereArgs: [userID]);
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Harcamalar(
          satir["harcamaID"] as int,
          satir["userID"] as int,
          satir["tarih"] as String,
          (satir["gelir"] as num).toDouble(),
          (satir["gider"] as num).toDouble(),
          satir["gelirAciklama"] as String,
          satir["giderAciklama"] as String);
    });
  }

  Future<void> deleteGelirGider(int harcamaID) async {
    var db = await DatabaseHelper().veritabaniErisim();
    await db.delete(
      'gelir_gider',
      where: 'harcamaID = ?',
      whereArgs: [harcamaID],
    );
  }

  Future<Users?> kullaniciVerisiGetir(String userName, String password) async {
    var db = await DatabaseHelper().veritabaniErisim();
    var maps = await db.query("users", where: "userName=? AND password=?", whereArgs: [userName, password]);
    if (maps.isNotEmpty) {
      var satir = maps[0];
      var u0 = Users(
          userID: satir["userID"] as int,
          userName: satir["userName"] as String,
          password: satir["password"] as String,
          imageFile: satir["imageFile"] != null ? File(satir["imageFile"] as String) : null);
      return u0;
    }
    return null;
  }
}
