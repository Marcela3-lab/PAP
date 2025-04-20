import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interface/Adicionar_progresso.dart';
import 'package:flutter_application_1/Interface/utilizador_semlogin_page.dart';
import 'package:flutter_application_1/Interface/utilizador_logado_page.dart';
import 'package:flutter_application_1/Provider/AdicionarTarefa_provider.dart';
import 'package:flutter_application_1/Provider/Adicionar_progresso.dart';
import 'package:flutter_application_1/Provider/Adicionarobjetivo_Provider.dart';
import 'package:flutter_application_1/Provider/calendario_provider.dart';
import 'package:flutter_application_1/Provider/objetivo_provider.dart';
import 'package:flutter_application_1/Provider/utilizador_semlogin_provider.dart';
import 'package:flutter_application_1/Provider/utilizador_logado_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UtilizadorSemloginProvider()),
    ChangeNotifierProvider(create: (_) => UtilizadorLogadoProvider()),
    ChangeNotifierProvider(create: (_) => CalendarioProvider()),
    ChangeNotifierProvider(create: (_) => AdicionartarefaProvider()),
    ChangeNotifierProvider(create: (_) => AdicionarobjetivoProvider()),
    ChangeNotifierProvider(create: (_) => ObjetivoProvider()),
    ChangeNotifierProvider(create: (_) => AdicionarProgressoProvider()),
  ], child: const MyApp()));
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

class Tela_Principal extends StatefulWidget {
  const Tela_Principal({super.key});

  @override
  _Tela_PrincipalState createState() => _Tela_PrincipalState();
}

class _Tela_PrincipalState extends State<Tela_Principal> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("StudyTime",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 109, 10, 148),
                  letterSpacing: 1.5,
                )),
            const SizedBox(height: 60),
            Image.asset(
              'assets/imagens/img.jpeg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              scale: 1.0,
            ),
            const SizedBox(height: 80),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 109, 10, 148),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 152)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const UtilizadorSemlogin()),
                  );
                  style:
                  ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  );
                },
                child: const Text("Criar conta")),
            const SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 109, 10, 148),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 140)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const Utilizadorlogado()),
                  );
                  style:
                  ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  );
                },
                child: const Text("Acessar Conta")),
            const SizedBox(
              height: 20,
            ),
          ], //fim do children
        ), // fim do alinhamento
      ), //fim do body center
    );
  }
}
