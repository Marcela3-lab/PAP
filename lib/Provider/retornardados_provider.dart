import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RetornardadosProvider extends ChangeNotifier {
  List<Map<String, dynamic>> dadosuser = [];

  List<Map<String, dynamic>> get dadosdouser => dadosuser;
  Future<List<Map<String, dynamic>>> buscaruserdados() async {
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    final String url = "http://192.168.1.29/retornardados.php?id_user=$iduser";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Body recebido: ${response.body}');

        List<dynamic> dados = json.decode(response.body);
        dadosuser = List<Map<String, dynamic>>.from(dados);
        print("bb $dadosuser");
        notifyListeners();
        return dadosuser;
      } else {
        print("Erro no servidor: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro de conexão: $e");
      return [];
    }
  }
}
