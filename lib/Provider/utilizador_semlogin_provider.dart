import 'package:flutter/material.dart';
import 'package:learn_logs/Navegacao_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UtilizadorSemloginProvider extends ChangeNotifier {
//1º funcao que envia os dados pra base de dados
  Future<void> enviarDados(
      nome, String email, String senha, BuildContext context) async {
    const String url = "http://192.168.1.187/index.php";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'nome': nome,
          'email': email,
          'senha': senha,
        },
      );
      print("Resposta do servidor: ${response.body}");

      if (response.statusCode == 200) {
        var dadosUser = jsonDecode(response.body);
        if (dadosUser["sucesso"]) {
          int idUser = int.parse(dadosUser['id_user'].toString());
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('nome', nome);
          await prefs.setInt('id', idUser);

          print("Dados salvos no SharedPreferences:");
          print("Nome salvo: ${prefs.getString('nome')}");
          print("ID Salvo: ${prefs.getInt('id')}");
        } else {
          print(response.body);
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
          notifyListeners();
        }
      } else {
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
    } catch (e) {
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
