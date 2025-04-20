import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ObjetivoProvider extends ChangeNotifier {
//Função pra deletar objetivo

  // Função para buscar dados do servidor
  Future<void> deletarObjetivo(id_objetivo) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.189/deletar_objetivos.php'),
      body: {'id_objetivo': id_objetivo.toString()},
    );
    if (response.statusCode == 200) {
      print("Objetivo deletado com sucesso!");
    } else {
      print("Erro ao deletar objetivo: ${response.statusCode}");
    }
  }

  List<Map<String, dynamic>> _objetivos = [];

  List<Map<String, dynamic>> get objetivos => _objetivos;
  Future<List<Map<String, dynamic>>> buscarobjetivos() async {
    final String url = "http://192.168.1.189/buscar_objetivos.php";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var dados = jsonDecode(response.body);
        _objetivos = List<Map<String, dynamic>>.from(dados);
//CONVERTER COR

        for (var item in _objetivos) {
          int cor = int.tryParse(item['cor'].toString()) ?? 0;
          if (cor >= 8) {
            item['cor'] = Colors.red.shade200;
          } else if (cor >= 5) {
            item['cor'] = Colors.orange.shade200;
          } else {
            item['cor'] = Colors.green.shade200;
          }
        }
        notifyListeners();
        print("Objetivos : $_objetivos");

        return _objetivos;
      } else {
        print("erro ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro de conexão: $e");
      return [];
    }
  }
}
