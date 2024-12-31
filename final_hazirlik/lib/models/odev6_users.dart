import 'dart:io';

import 'package:final_hazirlik/models/odev6_harcamalar.dart';


class Users {
  late int userID;
  late String userName;
  late String password;
  File? imageFile;
  Harcamalar? harcamalar;

  Users(
      {required this.userID,
      required this.userName,
      required this.password,
      required this.imageFile,
      this.harcamalar});
}
