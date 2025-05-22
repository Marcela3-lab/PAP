// progresso_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProgressoProvider extends ChangeNotifier {
  List<dynamic> _objetivos = [];

  List<dynamic> get objetivos => _objetivos;

  Future<void> buscarObjetivos() async {
    final prefs = await SharedPreferences.getInstance();
    final int? idUsuario = prefs.getInt('id');
    print('ID do usuário armazenado: $idUsuario');

    if (idUsuario == null) return;

    final url =
        Uri.parse("http://192.168.1.187/dropdown.php?id_user=$idUsuario");
    final response = await http.get(url);

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      _objetivos = jsonDecode(response.body);
      print('Objetivos carregados: $_objetivos');
      notifyListeners();
    } else {
      print("Erro ao carregar objetivos: ${response.statusCode}");
    }
  }

//Checar campos
  bool checar(context, tipoavanco, tipometa) {
    if ((tipoavanco.toLowerCase().trim() == "horas" ||
            tipoavanco.toLowerCase().trim() == "minutos") &&
        (tipometa.toLowerCase().trim() == "minutos" ||
            tipometa.toLowerCase().trim() == "horas")) {
      return true;
    }

    return false;
  }

  double calcularProgresso(double avanco, double meta, String tipoAvanco,
      String tipoMeta, BuildContext context) {
    double avancoConvertido;

    if (tipoMeta.toLowerCase().trim() == "horas" &&
        tipoAvanco.toLowerCase().trim() == "minutos") {
      avancoConvertido = avanco / 100;
    } else {
      avancoConvertido = 0;
    }
    if (tipoMeta.toLowerCase().trim() == "horas" &&
        tipoAvanco.toLowerCase().trim() == "horas") {
      avancoConvertido = avanco;
    }
    if (tipoMeta.toLowerCase().trim() == "minutos" &&
        tipoAvanco.toLowerCase().trim() == "horas") {
      avancoConvertido = meta;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Parabéns'),
          content: Text('Você cumpriu mais do que a sua meta'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('OK')),
          ],
        ),
      );
    }
    if (tipoMeta.toLowerCase().trim() == "minutos" &&
        tipoAvanco.toLowerCase().trim() == "minutos") {
      avancoConvertido = avanco;
    }
    print("avanconveritdo: $avancoConvertido");
    print("meta: $meta");

    double progresso = avancoConvertido / meta;
    return progresso.clamp(0.0, 1.0);
  }
}
