import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interface/home.dart';
import 'package:flutter_application_1/Login/ultilizador_semlogin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UltilizadorLogado extends StatelessWidget {
  const UltilizadorLogado({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ("MeTime"),
      home: Verificacao(),
    );
  }
}

class Verificacao extends StatefulWidget {
  const Verificacao({super.key});

  @override
  _VerificacaoState createState() => _VerificacaoState();
}

class _VerificacaoState extends State<Verificacao> {
  final TextEditingController _nome = TextEditingController();
  Future<void> verificarlogin() async {
    const String url = "http://192.168.1.71/index.php";
    final response = await http.get(Uri.parse(url));
    bool usercerto = false;
    var dados = jsonDecode(response.body);
    for (var user in dados) {
      if (user['nome'] == _nome.text) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Home()),
        );

        usercerto = true;
        break;
      }
    }
    if (!usercerto) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Erro!"),
          content: Text("Utilizador não encontrado"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 178, 202),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Acessar Conta",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  const SizedBox(height: 30),
                  const Text(
                      "Digite seu nome de utilizador para acessar sua conta",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      )),
                  const SizedBox(height: 90),
                  TextFormField(
                    controller: _nome,
                    decoration: const InputDecoration(
                        labelText: "Nome de Utilizador",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                        filled: true,
                        fillColor: Colors.white),
                    validator: (value) {
                      if (value == null) {
                        return "O nome de ultilizador não pode ser nulo";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(221, 255, 167, 51),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 149),
                    ),
                    onPressed: () {
                      verificarlogin();
                    },
                    child: const Text("Acessar"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(221, 255, 219, 173),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 143),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const UltilizadorSemlogin()),
                      );
                    },
                    child: const Text("Criar conta"),
                  )
                ],
              ))),
    );
  }
}
