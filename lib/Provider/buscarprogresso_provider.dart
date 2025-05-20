import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuscarprogressoProvider extends ChangeNotifier {
  List<Map<String, dynamic>> progressos = [];

  // Função para buscar dados do servidor
  Future<List<Map<String, dynamic>>> buscarDados(String dia) async {
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    final String url =
        "http://192.168.1.29/buscar_progresso.php?dia=$dia&id_user=$iduser";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Body recebido: ${response.body}');

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
  void carregarprogresso(DateTime selectedDay) async {
    String dataFormatada = DateFormat('yyyy-MM-dd').format(selectedDay);
    progressos = await buscarDados(dataFormatada);
    notifyListeners();
  }

  void concluida(cor) async {}
}
