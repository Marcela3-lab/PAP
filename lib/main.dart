import 'package:flutter/material.dart';
import 'package:flutter_application_1/Login/ultilizador_semlogin.dart';
import 'package:flutter_application_1/Login/ultilizador_logado.dart';

//Função principal pra inicial o aplicativo, que no caso se chama MyApp
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      home: const Tela_Principal(),
    );
  }
}

class Tela_Principal extends StatelessWidget {
  const Tela_Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 208, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("MeTime",
                style: TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 255, 255, 255),
                  letterSpacing: 1.5,
                )),
            const SizedBox(height: 50),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 152)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const UltilizadorSemlogin()),
                  );
                },
                child: const Text("Criar conta")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 143)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UltilizadorLogado()));
                },
                child: const Text("Ja tenho conta")),
          ], //fim do children
        ), // fim do alinhamento
      ), //fim do body center
    );
  }
}
