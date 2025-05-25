import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarioProvider extends ChangeNotifier {
  List<Map<String, dynamic>> eventos = [];

  Future<List<Map<String, dynamic>>> buscarDados(String dia) async {
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    final String url =
        "http://192.168.1.199/buscar_eventos.php?dia=$dia&id_user=$iduser";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(response.body);

        return List<Map<String, dynamic>>.from(dados);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  void carregarEventos(DateTime selectedDay) async {
    String dataFormatada = DateFormat('yyyy-MM-dd').format(selectedDay);
    eventos = await buscarDados(dataFormatada);
    notifyListeners();
  }
}
