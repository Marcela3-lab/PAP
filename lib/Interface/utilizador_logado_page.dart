import 'package:flutter/material.dart';
import 'package:learn_logs/Navegacao_page.dart';
import 'package:learn_logs/Provider/utilizador_logado_provider.dart';
import 'package:provider/provider.dart';

import 'package:learn_logs/Interface/utilizador_semlogin_page.dart';

class Utilizadorlogado extends StatelessWidget {
  const Utilizadorlogado({super.key});

  @override

//1º funcao que verifica se o nome do user ta no shared prefernces

  @override
  Widget build(BuildContext context) {
    final TextEditingController nome = TextEditingController();
    final TextEditingController senha = TextEditingController();
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color.fromARGB(246, 255, 238, 212),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 160),

                  const Text("Iniciar Sessão",
                      style: TextStyle(
                          fontSize: 30,
                          color: const Color.fromARGB(255, 143, 33, 134))),
                  const SizedBox(height: 48),
                  const Text("Digite seus dados para iniciar sessão",
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 143, 33, 134),
                        letterSpacing: 1.5,
                      )),
                  const SizedBox(height: 60),
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: senha,
                    decoration: const InputDecoration(
                      labelText: "Senha",
                      prefixIcon: Icon((Icons.password),
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
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                      width: largura * 0.9,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 143, 33, 134),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                        ),
                        onPressed: () async {
                          if (nome.text.isNotEmpty && senha.text.isNotEmpty) {
                            await Provider.of<UtilizadorLogadoProvider>(context,
                                    listen: false)
                                .carregar_user(context, nome.text.trim(),
                                    senha.text.trim());
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Erro"),
                                content: Text("Utilizador não encontrado"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Ok"),
                                  )
                                ],
                              ),
                            );
                            return;
                          }
                        },
                        child: const Text("Iniciar Sessão"),
                      )),

                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: largura * 0.9,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 143, 33, 134),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UtilizadorSemlogin()),
                                (Route<dynamic> route) => false);
                          },
                          child: const Text("Criar Conta"))),
                ],
              ),
            ),
          ),
        ));
  }
}
