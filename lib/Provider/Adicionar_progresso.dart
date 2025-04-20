import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdicionarProgressoProvider extends ChangeNotifier {
  Future<void> adicionarProgresso(
      BuildContext context, String objetivo, String meta, String avanco) async {
    const String url = "http://192.168.1.189/proguesso.php";
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

    try {
      final response = await http.post(Uri.parse(url), body: {
        'objetivo': objetivo,
        'meta': meta,
        'avanco': avanco,
        'id_user': iduser.toString(),
      });
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
