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
    const String url = "http://192.168.1.199/Adicionar_progresso.php";
    final prefs = await SharedPreferences.getInstance();
    int? iduser = prefs.getInt('id');

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

        if (data["status"] == "sucesso") {}
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Sucesso"),
              content: Text("Seu progresso foi adicionada com sucesso"),
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
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Erro"),
              content:
                  Text("Erro ao adicionar progresso ${response.statusCode}"),
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
