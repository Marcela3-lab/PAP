import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdicionarProgressoProvider extends ChangeNotifier {
  Future<void> adicionarProgresso(
    BuildContext context,
    String objetivo,
    String progresso,
    String avanco,
    String tipoavanco,
    String meta,
    String tipometa,
    String dia,
  ) async {
    const String url = "http://192.168.1.29/Adicionar_progresso.php";
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');
    print('Enviando progresso...');
    print('objetivo: $objetivo');
    print('progresso: $progresso');
    print('avanco: $avanco');
    print('tipoavanco: $tipoavanco');
    print('meta: $meta');
    print('tipometa: $tipometa');
    print('dia: $dia');
    print('id_user: $iduser');

    try {
      final response = await http.post(Uri.parse(url), body: {
        'objetivo': objetivo,
        'progresso': progresso,
        'avanco': avanco,
        'tipoavanco': tipoavanco,
        'meta': meta,
        'tipometa': tipometa,
        'dia': dia,
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
