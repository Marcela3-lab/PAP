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

  //Funcao pra ver se há campos vazios
  Future<bool> verificarcampos(
      BuildContext context, titulo, descricao, duracao, cor) async {
    if (titulo.isNotEmpty &&
        descricao.isNotEmpty &&
        duracao.isNotEmpty &&
        cor.isNotEmpty) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Dados incorretos"),
                content: Text("Preencha todos os campos"),
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

  //Verificar a cor
  Future<bool> verificarcor(BuildContext context, int cor) async {
    if (cor >= 1 && cor <= 10) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Dados incorretos"),
                content: Text("Deve-se digitar um numero entre 1 e 10"),
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
    duracao,
    cor,
  ) async {
    const String url = "http://192.168.1.189/objetivos.php";
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'objetivo': titulo,
          'descricao': descricao,
          'duracao': duracao,
          'cor': cor,
          'id_user': iduser.toString(),
        },
      );
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
