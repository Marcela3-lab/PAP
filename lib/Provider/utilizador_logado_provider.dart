import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_logs/Navegacao_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UtilizadorLogadoProvider extends ChangeNotifier {
  Future<void> carregar_user(BuildContext context, nome, senha) async {
    final String url =
        "http://192.168.1.187/checarsenha.php?nome=$nome&senha=$senha";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body == 'null' || response.body.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Erro"),
              content: Text("Não foi possivel encontrar nenhum registo"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"),
                )
              ],
            ),
          );
          return;
        }
        List<dynamic> dados = json.decode(response.body);
        Map<String, dynamic> dadosuser = dados[0];

        print('Body recebido: ${response.body}');

        print("nome:$nome");
        print("senha:$senha");

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nome', dadosuser['nome']);
        await prefs.setInt('id', int.parse(dadosuser['id'].toString()));

        print("Nome salvo: ${prefs.getString('nomeprefs')}");
        print("ID salvo: ${prefs.getInt('id_user')}");
        notifyListeners();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Navegacao(
            indiceInicial: 2,
          ),
        ));
      } else {
        print("Erro no servidor: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro de conexão: $e");
    }
  }
}
