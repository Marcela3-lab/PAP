import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UtilizadorSemloginProvider extends ChangeNotifier {
  Future<void> enviarDados(
      nome, String email, String senha, BuildContext context) async {
    const String url = "http://192.168.1.199/index.php";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'nome': nome,
          'email': email,
          'senha': senha,
        },
      );

      if (response.statusCode == 200) {
        var dadosUser = jsonDecode(response.body);
        if (dadosUser["sucesso"]) {
          int idUser = int.parse(dadosUser['id_user'].toString());
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('nome', nome);
          await prefs.setInt('id', idUser);
        } else {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Erro"),
                content: Text("Erro: ${dadosUser['erro']}"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"),
                  )
                ],
              ),
            );
          }
        }
      } else {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Erro"),
              content: Text("Erro ao enviar os dados. ${response.statusCode}"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"),
                )
              ],
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Erro"),
            content: Text("Não foi possível conectar ao servidor. $e"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ok"),
              )
            ],
          ),
        );
      }
    }
  }
}
