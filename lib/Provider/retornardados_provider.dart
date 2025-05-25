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

    final String url = "http://192.168.1.199/retornardados.php?id_user=$iduser";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(response.body);
        dadosuser = List<Map<String, dynamic>>.from(dados);
        notifyListeners();
        return dadosuser;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
