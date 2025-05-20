import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn_logs/Interface/utilizador_logado_page.dart';
import 'package:learn_logs/Provider/utilizador_semlogin_provider.dart';
import 'package:email_validator/email_validator.dart';

//Função principal pra inicial o aplicativo, que no caso se chama MyApp

//Define uma classe
class UtilizadorSemlogin extends StatelessWidget {
  const UtilizadorSemlogin({super.key});

  @override
  Widget build(BuildContext context) {
    final formchave = GlobalKey<FormState>();
    final TextEditingController nome = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController senha = TextEditingController();

    return Scaffold(
        backgroundColor: const Color.fromARGB(246, 255, 238, 212),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Form(
              key: formchave,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 140,
                  ),
                  const Text("Criar Conta",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Raleway",
                        color: const Color.fromARGB(255, 143, 33, 134),
                        letterSpacing: 1.5,
                      )),
                  const SizedBox(height: 30),
                  const Text("Digite seus dados para criar sua conta",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 143, 33, 134),
                        letterSpacing: 1.5,
                      )),
                  const SizedBox(height: 80),

                  //--nome
                  TextFormField(
                    controller: nome,
                    decoration: const InputDecoration(
                      labelText: "Nome de Utilizador",
                      prefixIcon: Icon((Icons.person),
                          color: Color.fromARGB(255, 0, 0, 0)),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      filled: true,
                      fillColor: (Color.fromARGB(255, 255, 255, 255)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um Nome válido';
                      } else if (value.length < 3) {
                        return 'Nome inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //-----email
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon((Icons.email),
                          color: Color.fromARGB(255, 0, 0, 0)),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um email válido';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //--senha
                  TextFormField(
                    controller: senha,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      prefixIcon: Icon((Icons.password),
                          color: Color.fromARGB(255, 0, 0, 0)),
                      labelText: "Senha",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: (Color.fromARGB(255, 255, 255, 255)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite uma senha';
                      } else if (value.length < 6) {
                        return 'Digite uma senha com mais de 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 143, 33, 134),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 143),
                    ),
                    onPressed: () {
                      if (formchave.currentState!.validate()) {
                        if (nome.text != "" &&
                            email.text != "" &&
                            senha.text != "") {
                          Provider.of<UtilizadorSemloginProvider>(context,
                                  listen: false)
                              .enviarDados(
                                  nome.text, email.text, senha.text, context);
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text('Erro'),
                                  content: Text(
                                      'Preencha todos os campos com dados corretos'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Fecha o dialog
                                      },
                                      child: Text('Fechar'),
                                    ),
                                  ]);
                            });
                      }
                    },
                    child: const Text("Criar Conta"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 143, 33, 134),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 130),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Utilizadorlogado()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text("Acessar Conta"))
                ],
              ),
            ),
          ),
        ));
  }
}
