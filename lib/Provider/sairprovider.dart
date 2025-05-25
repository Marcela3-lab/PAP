import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Sairprovider extends ChangeNotifier {
  Future<bool> apagaruser(context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Apagar Conta"),
          content: const Text(
              "Após apagar a conta será necessário registar-se novamente. Deseja continuar?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );
    if (confirmar != true) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    final int? idUsuario = prefs.getInt('id');

    final url = Uri.parse("http://192.168.1.199/sair.php?id_user=$idUsuario");
    final response = await http.get(url);

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
