import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/Interface/utilizador_logado_page.dart';
import 'package:flutter_application_1/Provider/utilizador_semlogin_provider.dart';
//Função principal pra inicial o aplicativo, que no caso se chama MyApp

//Define uma classe
class UtilizadorSemlogin extends StatelessWidget {
  const UtilizadorSemlogin({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nome = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController senha = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 177, 198, 236),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              const Text("Criar Conta",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Raleway",
                    color: Color.fromARGB(255, 255, 255, 255),
                    letterSpacing: 1.5,
                  )),
              const SizedBox(height: 30),
              const Text("Digite seus dados para criar sua conta",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  )),
              const SizedBox(height: 80),
              //--nome
              TextFormField(
                controller: nome,
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
              const SizedBox(height: 20),

              //-----email
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon:
                      Icon((Icons.email), color: Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                ),
              ),
              const SizedBox(height: 20),

              //--senha
              TextFormField(
                controller: senha,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
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
              ),
              const SizedBox(height: 50),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(221, 255, 167, 51),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 143),
                ),
                onPressed: () {
                  Provider.of<UtilizadorSemloginProvider>(context,
                          listen: false)
                      .enviarDados(nome.text, email.text, senha.text, context);
                },
                child: const Text("Criar Conta"),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(221, 255, 219, 173),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 130),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const Utilizadorlogado()),
                    );
                  },
                  child: const Text("Acessar Conta"))
            ],
          ),
        ),
      ),
    );
  }
}
