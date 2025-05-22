import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verificaruser extends ChangeNotifier {
  List<Map<String, dynamic>> dadosuser = [];

  Future<bool> buscarnome(context, nome) async {
    final String url = "http://192.168.1.187/verificarnome.php";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Body recebido: ${response.body}');

        List<dynamic> dados = json.decode(response.body);
        dadosuser = List<Map<String, dynamic>>.from(dados);
      } else {
        print("Erro no servidor: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro de conexão: $e");
    }

    print("nome digitado: $nome");
    if (dadosuser.any((user) => user['nome'] == nome)) {
      return true;
    }
    return false;
  }
}
