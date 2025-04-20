import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navegacao_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilizadorLogadoProvider extends ChangeNotifier {
  Future<void> carregar_user(BuildContext context, nome) async {
    final prefs = await SharedPreferences.getInstance();

    String? nomeSalvo = prefs.getString('nome');
    int? idSalvo = prefs.getInt('id');

    print("Nome salvo: $nomeSalvo");
    print("ID salvo: $idSalvo");

    if (nomeSalvo?.trim() == nome.trim()) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                Navegacao(nomeuser: nomeSalvo!, primeiroacesso: false)),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Erro"),
                content: Text("Erro: Utilizador não encontrado"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"),
                  )
                ],
              ));
    }
  }
}
