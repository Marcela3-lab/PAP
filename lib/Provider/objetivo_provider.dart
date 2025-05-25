import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ObjetivoProvider extends ChangeNotifier {
  Future<void> deletarObjetivo(idobjetivo) async {
    await http.post(
      Uri.parse('http://192.168.1.199/deletar_objetivos.php'),
      body: {'id_objetivo': idobjetivo.toString()},
    );
  }

  List<Map<String, dynamic>> _objetivos = [];

  List<Map<String, dynamic>> get objetivos => _objetivos;
  Future<List<Map<String, dynamic>>> buscarobjetivos() async {
    final prefs = await SharedPreferences.getInstance();
    int? idUser = prefs.getInt('id');

    final String url =
        "http://192.168.1.199/buscar_objetivos.php?id_user=$idUser";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var dados = jsonDecode(response.body);
        _objetivos = List<Map<String, dynamic>>.from(dados);

        for (var item in _objetivos) {
          int cor = int.tryParse(item['cor'].toString()) ?? 0;

          if (cor >= 8 && cor <= 10) {
            item['cor'] = Colors.red.shade200;
          } else if (cor >= 1 && cor <= 4) {
            item['cor'] = Colors.green.shade200;
          } else if (cor >= 5 && cor <= 7) {
            item['cor'] = Colors.orange.shade200;
          } else if (cor < 0 || cor > 10) {
            item['cor'] = Color.fromARGB(255, 255, 255, 255);
          }
        }

        notifyListeners();

        return _objetivos;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
