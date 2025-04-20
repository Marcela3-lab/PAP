import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CalendarioProvider extends ChangeNotifier {
  List<Map<String, dynamic>> eventos = [];

  // Função para buscar dados do servidor
  Future<List<Map<String, dynamic>>> buscarDados(String dia) async {
    final String url = "http://192.168.3.64/buscar_eventos.php?dia=$dia";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(response.body);
        return List<Map<String, dynamic>>.from(dados);
      } else {
        print("Erro no servidor: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro de conexão: $e");
      return [];
    }
  }

  // Função para carregar eventos ao selecionar um dia
  void carregarEventos(DateTime selectedDay) async {
    String dataFormatada = DateFormat('yyyy-MM-dd').format(selectedDay);
    eventos = await buscarDados(dataFormatada);
    notifyListeners();
  }
}
