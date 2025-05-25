import 'package:flutter/material.dart';
import 'package:learn_logs/Provider/home-containersProvider/nobjetivos_provider.dart';
import 'package:learn_logs/Provider/home-containersProvider/nprogressos_provider.dart';
import 'package:learn_logs/Provider/home-containersProvider/tarefasfeitas_provider.dart';
import 'package:learn_logs/Provider/home-containersProvider/tarefaspendentes_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  String? nomeprefs;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tarefas1Provider =
          Provider.of<Tarefaspendentesprovider>(context, listen: false);
      tarefas1Provider.numtarefaspen();
      final tarefas2Provider =
          Provider.of<Tarefasfeitasprovider>(context, listen: false);
      tarefas2Provider.numtarefasfeitas();
      final objetivos3Provider =
          Provider.of<Nobjetivos>(context, listen: false);
      objetivos3Provider.ndeobjtivos();
      final progresso4Provider =
          Provider.of<Nprogressosprovider>(context, listen: false);
      progresso4Provider.numdeprogrssos();
    });
    buscarnome();
  }

  void buscarnome() async {
    final prefs = await SharedPreferences.getInstance();
    String? nomesalvo = prefs.getString('nome');
    setState(() {
      nomeprefs = nomesalvo;
    });
  }

  Widget nome(nomeuser) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Text('Olá, $nomeuser!',
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 25,
            )));
  }

  Widget tarefaspendentes() {
    return Container(
        width: 160,
        height: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 245, 188),
              Color.fromARGB(255, 255, 228, 248),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.4),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Consumer<Tarefaspendentesprovider>(
          builder: (context, provider, child) {
            return Text(
              'Tarefas Pendentes: ${provider.numTarefas}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Color.fromARGB(255, 143, 33, 134),
              ),
            );
          },
        ));
  }

  Widget tarefasconcluidas() {
    return Container(
      width: 160,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color.fromARGB(255, 250, 244, 191), Color(0xFFFFEAF1)]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.4),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Consumer<Tarefasfeitasprovider>(
        builder: (context, provider, child) {
          return Text(
            'Tarefas Concluídas: ${provider.numTarefas}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Color.fromARGB(255, 143, 33, 134),
            ),
          );
        },
      ),
    );
  }

  Widget objetivoprogresso() {
    return Container(
      width: 160,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color.fromARGB(255, 250, 244, 191), Color(0xFFFFEAF1)]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.4),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Consumer<Nobjetivos>(
        builder: (context, provider, child) {
          return Text(
            'Objetivos: ${provider.numobj}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Color.fromARGB(255, 143, 33, 134),
            ),
          );
        },
      ),
    );
  }

  Widget progressodia() {
    return Container(
        width: 160,
        height: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 245, 188),
              Color.fromARGB(255, 255, 228, 248),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.4),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Consumer<Nprogressosprovider>(
          builder: (context, provider, child) {
            return Text(
              'Progressos: ${provider.numdepro}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Color.fromARGB(255, 143, 33, 134),
              ),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 30),
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color.fromARGB(255, 143, 33, 134),
          child: Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        nome(nomeprefs),
        const SizedBox(height: 1),
        Text(
          ' Um dia produtivo começa com um bom plano.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 48),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              tarefaspendentes(),
              SizedBox(
                width: 15,
              ),
              tarefasconcluidas(),
            ]),
        const SizedBox(height: 15),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              objetivoprogresso(),
              SizedBox(
                width: 15,
              ),
              progressodia()
            ]),
      ]),
    )));
  }
}
