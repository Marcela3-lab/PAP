import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TarefasfeitasProvider extends ChangeNotifier {
  int numTarefas = 0;
  get numdeTarefas => numTarefas;

  Future<int> numtarefasfeitas() async {
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');
    print("id_user container2: $iduser");

    final String url = "http://192.168.1.29/Tarefas_feitas.php?id_user=$iduser";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Body recebido: ${response.body}');

        dynamic dados = json.decode(response.body);
        if (dados.isNotEmpty && dados != null) {
          numTarefas = int.parse(dados['total2']);
          notifyListeners();
          return numTarefas;
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

  void verificarSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    // Pega todos os dados salvos
    Set<String> keys = prefs.getKeys();

    for (String key in keys) {
      var value = prefs.get(key);
      print('Chave: $key => Valor: $value');
    }
  }
}
