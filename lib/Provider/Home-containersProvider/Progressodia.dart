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
    print("id_user container4: $iduser");

    final String url = "http://192.168.1.187/Progressodia.php?id_user=$iduser";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Body recebido: ${response.body}');

        dynamic dados = json.decode(response.body);
        if (dados.isNotEmpty && dados != null) {
          numpro = int.parse(dados['total4']);
          notifyListeners();
          return numpro;
        }
      } else {
        print("Erro no servidor: ${response.statusCode}");
        return 6;
      }
    } catch (e) {
      print("Erro de conexão: $e");
    }
    return 9;
  }
}
