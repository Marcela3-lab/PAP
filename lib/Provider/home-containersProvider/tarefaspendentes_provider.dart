import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Tarefaspendentesprovider extends ChangeNotifier {
  int numTarefas = 0;
  get numdeTarefas => numTarefas;

  Future<int> numtarefaspen() async {
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    final String url =
        "http://192.168.1.199/Tarefaspendentes.php?id_user=$iduser";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic dados = json.decode(response.body);
        if (dados.isNotEmpty && dados != null) {
          numTarefas = int.parse(dados['total1']);
          notifyListeners();
          return numTarefas;
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
