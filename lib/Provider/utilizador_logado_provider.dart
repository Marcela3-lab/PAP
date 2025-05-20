import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_logs/Navegacao_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UtilizadorLogadoProvider extends ChangeNotifier {
  Future<void> carregar_user(BuildContext context, nome, senha) async {
    final prefs = await SharedPreferences.getInstance();

    String? nomeSalvo = prefs.getString('nome');
    int? idSalvo = prefs.getInt('id');
    bool dados = false;
    print("Nome salvo: $nomeSalvo");
    print("ID salvo: $idSalvo");
    print("nome:$nome");
    print("senha:$senha");

    final String url =
        "http://192.168.1.6/checarsenha.php?nome=$nome&senha=$senha";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Body recebido: ${response.body}');

        dados = json.decode(response.body) == true;
      } else {}
    } catch (e) {
      print("Erro de conexão: $e");
      return;
    }
    if (nomeSalvo == nome && dados == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => Navegacao(
                  indiceInicial: 2,
                )),
      );
      notifyListeners();
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Erro"),
                content: Text("Erro: Utilizador não encontrado"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"),
                  )
                ],
              ));
    }
  }
}
