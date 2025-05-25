import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Adicionarobjetivoprovider extends ChangeNotifier {
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

  Future<void> adicionarobjetivo(
    BuildContext context,
    titulo,
    descricao,
    meta,
    tipo,
    cor,
  ) async {
    final currentContext = context;
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    String url = "http://192.168.1.199/objetivos.php";

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

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        if (currentContext.mounted) {
          showDialog(
            context: currentContext,
            builder: (context) => AlertDialog(
              title: Text("Sucesso"),
              content: Text("objetivo adicionado com sucesso"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(()),
                  child: Text("Ok"),
                )
              ],
            ),
          );
        }
      } else {
        if (context.mounted) {
          showDialog(
            context: currentContext,
            builder: (context) => AlertDialog(
              title: Text("Erro"),
              content:
                  Text("Erro ao adicionar objetivo ${response.statusCode}"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Ok"),
                )
              ],
            ),
          );
        }
      }
    } catch (e) {
      if (currentContext.mounted) {
        showDialog(
          context: currentContext,
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
}
