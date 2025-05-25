import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Nprogressosprovider extends ChangeNotifier {
  int numpro = 0;
  get numdepro => numpro;

  Future<int> numdeprogrssos() async {
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    final String url = "http://192.168.1.199/Progressodia.php?id_user=$iduser";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic dados = json.decode(response.body);
        if (dados.isNotEmpty && dados != null) {
          numpro = int.parse(dados['total4']);
          notifyListeners();
          return numpro;
        }
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }
}
