import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdicionarobjetivoProvider extends ChangeNotifier {
//Função para verificar a duracao
  Future<bool> verificarduracao(BuildContext context, int duracao) async {
    if (duracao >= 1 && duracao <= 24) {
      return true;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Dados incorretos"),
          content: Text("A duração deve ser entre 1 e 24 horas"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            )
          ],
        ),
      );
      return false;
    }
  }
  //Funcao verificar tipo

  //Funcao pra ver se há campos vazios
  Future<bool> verificarcampos(
      BuildContext context, titulo, descricao, duracao, tipo) async {
    int? duracaoint = int.tryParse(duracao);
    if (titulo.isNotEmpty &&
        duracao.isNotEmpty &&
        duracaoint != null &&
        tipo != null) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Dados incorretos"),
                content: Text("Preencha todos os campos com dados válidos"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"),
                  )
                ],
              ));
      return false;
    }
  }

  //Funcao principal pra mandar pra base de dados
  Future<void> adicionarobjetivo(
    BuildContext context,
    titulo,
    descricao,
    meta,
    tipo,
    cor,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    String url = "http://192.168.1.29/objetivos.php";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'titulo': titulo,
          'descricao': descricao,
          'meta': meta,
          'tipo': tipo,
          'cor': cor,
          'id_user': iduser.toString(),
        },
      );
      print('Resposta do servidor: ${response.body}');

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);

        if (data["status"] == "sucesso") {
          print(response.body);
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Sucesso"),
            content: Text("Tarefa adicionada com sucesso"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(()),
                child: Text("Ok"),
              )
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Erro"),
            content: Text("Erro ao adicionar tarefa ${response.statusCode}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Ok"),
              )
            ],
          ),
        );
        print("Response body: ${response.body}");
      }
    } catch (e, stackTrace) {
      print("Erro: $e");
      print("StackTrace: $stackTrace");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Erro"),
          content: Text("Não foi possível conectar ao servidor. $e "),
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
