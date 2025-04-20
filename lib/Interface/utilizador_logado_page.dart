import 'package:flutter/material.dart';
import 'package:flutter_application_1/Provider/utilizador_logado_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/Interface/utilizador_semlogin_page.dart';

class Utilizadorlogado extends StatelessWidget {
  const Utilizadorlogado({super.key});

  @override

//1º funcao que verifica se o nome do user ta no shared prefernces

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nome = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 177, 198, 236),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Iniciar Sessão",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Raleway",
                    color: Color.fromARGB(255, 255, 255, 255),
                    letterSpacing: 1.5,
                  )),
              const SizedBox(height: 30),
              const Text("Digite seu nome de utilizador para iniciar sessão",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    letterSpacing: 1.5,
                  )),
              const SizedBox(height: 60),
              //--nome
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(
                  labelText: "Nome de Utilizador",
                  prefixIcon:
                      Icon((Icons.person), color: Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  filled: true,
                  fillColor: (Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              const SizedBox(height: 60),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(221, 255, 167, 51),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 132),
                ),
                onPressed: () {
                  Provider.of<UtilizadorLogadoProvider>(context, listen: false)
                      .carregar_user(context, _nome.text);
                },
                child: const Text("Acessar Conta"),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(221, 255, 219, 173),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 140),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const UtilizadorSemlogin()),
                    );
                  },
                  child: const Text("Criar Conta"))
            ],
          ),
        ),
      ),
    );
  }
}
