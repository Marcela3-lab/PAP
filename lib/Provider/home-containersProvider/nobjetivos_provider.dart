import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Nobjetivos extends ChangeNotifier {
  int numobj = 0;
  get numdeobj => numobj;

  Future<int> ndeobjtivos() async {
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    final String url = "http://192.168.1.199/Nobjetivos.php?id_user=$iduser";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic dados = json.decode(response.body);
        if (dados != null && dados.isNotEmpty) {
          numobj = int.parse(dados['total3']);
          notifyListeners();
          return numobj;
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
