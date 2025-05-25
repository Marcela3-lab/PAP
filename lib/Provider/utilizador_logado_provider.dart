import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learn_logs/Navegacao_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UtilizadorLogadoProvider extends ChangeNotifier {
  Future<void> carregaruser(BuildContext context, nome, senha) async {
    final String url =
        "http://192.168.1.199/checarsenha.php?nome=$nome&senha=$senha";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body == 'null' || response.body.isEmpty) {
          if (context.mounted) {
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
          }
          return;
        }

        List<dynamic> dados = json.decode(response.body);
        Map<String, dynamic> dadosuser = dados[0];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nome', dadosuser['nome']);
        await prefs.setInt('id', int.parse(dadosuser['id'].toString()));

        notifyListeners();
        if (context.mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Navegacao(
              indiceInicial: 2,
            ),
          ));
        }
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Erro"),
            content: Text("Falha ao conectar."),
          ),
        );
      }
    }
  }
}
