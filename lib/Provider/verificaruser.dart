import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Verificaruser extends ChangeNotifier {
  List<Map<String, dynamic>> dadosuser = [];

  Future<bool> buscarnome(context, nome, email) async {
    final String url = "http://192.168.1.199/verificarnome.php";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(response.body);
        dadosuser = List<Map<String, dynamic>>.from(dados);
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Erro"),
            content: Text("Erro ao verificar dados do utilizador"),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Erro"),
          content:
              Text("Falha ao estabelecer conexão. Tente novamente mais tarde."),
        ),
      );
    }

    if (dadosuser.any((user) => user['nome'] == nome) ||
        dadosuser.any((user) => user['email'] == email)) {
      return true;
    }

    return false;
  }
}
