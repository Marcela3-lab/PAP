import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sairshprovider extends ChangeNotifier {
  Future<bool> dadoslocais() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('nome');
    int? iduser = prefs.getInt('id');
    String? nome = prefs.getString('nome');

    if (iduser == null && nome == null) {
      return true;
    } else {
      return false;
    }
  }
}
