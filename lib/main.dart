import 'package:flutter/material.dart';
import 'package:learn_logs/Interface/utilizador_semlogin_page.dart';
import 'package:learn_logs/Interface/utilizador_logado_page.dart';
import 'package:learn_logs/Provider/adicionartarefa_provider.dart';
import 'package:learn_logs/Provider/adicionarprogresso_provider.dart';
import 'package:learn_logs/Provider/adicionarobjetivo_provider.dart';
import 'package:learn_logs/Provider/home-containersProvider/nobjetivos_provider.dart';
import 'package:learn_logs/Provider/home-containersProvider/nprogressos_provider.dart';
import 'package:learn_logs/Provider/home-containersProvider/tarefasfeitas_provider.dart';
import 'package:learn_logs/Provider/home-containersProvider/tarefaspendentes_provider.dart';
import 'package:learn_logs/Provider/sairsh_provider.dart';
import 'package:learn_logs/Provider/buscarprogresso_provider.dart';
import 'package:learn_logs/Provider/dropdown_progressoprovider.dart';
import 'package:learn_logs/Provider/calendario_provider.dart';
import 'package:learn_logs/Provider/objetivo_provider.dart';
import 'package:learn_logs/Provider/retornardados_provider.dart';
import 'package:learn_logs/Provider/sairprovider.dart';
import 'package:learn_logs/Provider/utilizador_semlogin_provider.dart';
import 'package:learn_logs/Provider/utilizador_logado_provider.dart';
import 'package:learn_logs/Provider/verificaruser.dart';
import 'package:learn_logs/checklogin.dart';
import 'package:provider/provider.dart';

import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_PT');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UtilizadorSemloginProvider()),
    ChangeNotifierProvider(create: (_) => UtilizadorLogadoProvider()),
    ChangeNotifierProvider(create: (_) => CalendarioProvider()),
    ChangeNotifierProvider(create: (_) => Tarefaspendentesprovider()),
    ChangeNotifierProvider(create: (_) => Tarefasfeitasprovider()),
    ChangeNotifierProvider(create: (_) => Nobjetivos()),
    ChangeNotifierProvider(create: (_) => Nprogressosprovider()),
    ChangeNotifierProvider(create: (_) => Adicionartarefaprovider()),
    ChangeNotifierProvider(create: (_) => Adicionarobjetivoprovider()),
    ChangeNotifierProvider(create: (_) => ObjetivoProvider()),
    ChangeNotifierProvider(create: (_) => AdicionarProgressoProvider()),
    ChangeNotifierProvider(create: (_) => ProgressoProvider()),
    ChangeNotifierProvider(create: (_) => BuscarprogressoProvider()),
    ChangeNotifierProvider(create: (_) => Sairprovider()),
    ChangeNotifierProvider(create: (_) => RetornardadosProvider()),
    ChangeNotifierProvider(create: (_) => Verificaruser()),
    ChangeNotifierProvider(create: (_) => Sairshprovider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'ConcertOne',
      ),
      debugShowCheckedModeBanner: false,
      home: const Checklogin(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  TelaPrincipalState createState() => TelaPrincipalState();
}

class TelaPrincipalState extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;

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
                  color: Color.fromARGB(255, 241, 184, 97),
                  size: 30,
                ),
                const Text("LearnLogs",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 143, 33, 134),
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
            SizedBox(
              width: largura * 0.9,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 143, 33, 134),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      )),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const UtilizadorSemlogin()),
                    );
                    ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                    );
                  },
                  child: const Text("Criar conta")),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: largura * 0.9,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 241, 184, 97),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      )),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const Utilizadorlogado()),
                    );

                    ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    );
                  },
                  child: const Text("Iniciar Sessão")),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
