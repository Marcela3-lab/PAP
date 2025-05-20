import 'package:flutter/material.dart';

import 'package:learn_logs/Interface/utilizador_semlogin_page.dart';
import 'package:learn_logs/Interface/utilizador_logado_page.dart';
import 'package:learn_logs/Provider/AdicionarTarefa_provider.dart';
import 'package:learn_logs/Provider/Adicionarprogresso_provider.dart';
import 'package:learn_logs/Provider/Adicionarobjetivo_Provider.dart';
import 'package:learn_logs/Provider/Home-containersProvider/Nobjetivos.dart';
import 'package:learn_logs/Provider/Home-containersProvider/Progressodia.dart';
import 'package:learn_logs/Provider/Home-containersProvider/Tarefas_feitas.dart';
import 'package:learn_logs/Provider/Home-containersProvider/Tarefaspendentes.dart';
import 'package:learn_logs/Provider/buscarprogresso_provider.dart';
import 'package:learn_logs/Provider/dropdown_progressoprovider.dart';
import 'package:learn_logs/Provider/calendario_provider.dart';
import 'package:learn_logs/Provider/objetivo_provider.dart';
import 'package:learn_logs/Provider/retornardados_provider.dart';
import 'package:learn_logs/Provider/sairprovider.dart';
import 'package:learn_logs/Provider/utilizador_semlogin_provider.dart';
import 'package:learn_logs/Provider/utilizador_logado_provider.dart';
import 'package:learn_logs/checklogin.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_PT');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UtilizadorSemloginProvider()),
    ChangeNotifierProvider(create: (_) => UtilizadorLogadoProvider()),
    ChangeNotifierProvider(create: (_) => CalendarioProvider()),
    ChangeNotifierProvider(create: (_) => AdicionartarefaProvider()),
    ChangeNotifierProvider(create: (_) => AdicionarobjetivoProvider()),
    ChangeNotifierProvider(create: (_) => ObjetivoProvider()),
    ChangeNotifierProvider(create: (_) => AdicionarProgressoProvider()),
    ChangeNotifierProvider(create: (_) => ProgressoProvider()),
    ChangeNotifierProvider(create: (_) => BuscarprogressoProvider()),
    ChangeNotifierProvider(create: (_) => TarefaspendentesProvider()),
    ChangeNotifierProvider(create: (_) => TarefasfeitasProvider()),
    ChangeNotifierProvider(create: (_) => Nobjetivos()),
    ChangeNotifierProvider(create: (_) => Nprogressosprovider()),
    ChangeNotifierProvider(create: (_) => Sairprovider()),
    ChangeNotifierProvider(create: (_) => RetornardadosProvider()),
  ], child: const MyApp()));
}

bool darkMode = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.baloo2TextTheme(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.baloo2TextTheme(),
      ),
      home: const Checklogin(),
    );
  }
}

class Tela_Principal extends StatefulWidget {
  const Tela_Principal({super.key});

  @override
  _Tela_PrincipalState createState() => _Tela_PrincipalState();
}

class _Tela_PrincipalState extends State<Tela_Principal> {
  bool darkMode = false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.flag_circle,
                  color: const Color.fromARGB(255, 241, 184, 97),
                  size: 30,
                ),
                const Text("LearnLogs",
                    style: TextStyle(
                      fontSize: 30,
                      color: const Color.fromARGB(255, 143, 33, 134),
                      letterSpacing: 1.5,
                    ))
              ],
            ),
            const SizedBox(height: 60),
            Image.asset(
              'assets/imagens/img.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              scale: 1.0,
            ),
            const SizedBox(height: 80),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 143, 33, 134),
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
                    backgroundColor: const Color.fromARGB(255, 241, 184, 97),
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
