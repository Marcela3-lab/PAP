import 'package:flutter/material.dart';
import 'package:learn_logs/Provider/Home-containersProvider/Nobjetivos.dart';
import 'package:learn_logs/Provider/Home-containersProvider/Progressodia.dart';
import 'package:learn_logs/Provider/Home-containersProvider/Tarefas_feitas.dart';
import 'package:learn_logs/Provider/Home-containersProvider/Tarefaspendentes.dart';
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
    buscarnome();
    final tarefas1Provider =
        Provider.of<TarefaspendentesProvider>(context, listen: false);
    tarefas1Provider.numtarefaspen();
    final tarefas2Provider =
        Provider.of<TarefasfeitasProvider>(context, listen: false);
    tarefas2Provider.numtarefasfeitas();
    final objetivos3Provider = Provider.of<Nobjetivos>(context, listen: false);
    objetivos3Provider.Ndeobjtivos();
    final progresso4Provider =
        Provider.of<Nprogressosprovider>(context, listen: false);
    progresso4Provider.numdeprogrssos();
  }

  void buscarnome() async {
    final prefs = await SharedPreferences.getInstance();
    String? nomesalvo = prefs.getString('nome');
    setState(() {
      nomeprefs = nomesalvo;
    });
  }

  Widget Nome(nomeuser) {
    print("nomeprefs: $nomeprefs");
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Text('Olá, $nomeuser!',
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 25,
            )));
  }
//--------------------------------------- 1-widget

  Widget Tarefaspendentes() {
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
        child: Consumer<TarefaspendentesProvider>(
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

//---------------------------------------2-widget
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
          color: Colors.white, // cor da borda
          width: 5, // espessura da borda
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
      child: Consumer<TarefasfeitasProvider>(
        builder: (context, provider, child) {
          return Text(
            'Tarefas Concluidas: ${provider.numTarefas}',
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
//---------------------------------------3-widget

  Widget objetivoprogeuesso() {
    return Container(
      width: 160,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color.fromARGB(255, 250, 244, 191), Color(0xFFFFEAF1)]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white, // cor da borda
          width: 5, // espessura da borda
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
//---------------------------------------4-widget

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
            color: Colors.white, // cor da borda
            width: 5, // espessura da borda
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
        // WIDGET NOME USER
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
        Nome(nomeprefs),
        const SizedBox(height: 10),
        Text(
          ' Vamos começar o seu dia?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 30),

        //CONTAINER 1

        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Tarefaspendentes(),
              SizedBox(
                width: 15,
              ),
              tarefasconcluidas(),
            ]),
        //outra linha
        const SizedBox(height: 15),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              objetivoprogeuesso(),
              SizedBox(
                width: 15,
              ),
              progressodia()
            ]),
      ]),
    )));
  }
}
