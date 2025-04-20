import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProgressoProvider extends ChangeNotifier {
  List<Map<String, dynamic>> progresso = [];
  Future<List<Map<String, dynamic>>> buscarprogresso(
      BuildContext context, String objetivo, String meta, String avanco) async {
    try {
      final response = await http
          .get(Uri.parse("http://192.168.1.189/buscar_proguesso.php"));
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(response.body);
        return List<Map<String, dynamic>>.from(dados);
      } else {
        print("Erro : ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("erro de conexão $e");
      return [];
    }
  }
}
