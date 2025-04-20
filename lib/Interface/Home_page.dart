import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String nomeuser;
  final bool primeiroacesso;
  const Home({super.key, required this.nomeuser, required this.primeiroacesso});

//widget pra edição do nome
  Widget Nome(nomeuser) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(
            primeiroacesso
                ? 'Seja bem-vindo, $nomeuser!'
                : 'Bem-vindo de volta, $nomeuser!',
            style: const TextStyle(
              fontSize: 25,
            )));
  }
//--------------------------------------- 1-widget

  Widget Numtarefas() {
    return Container(
      width: 160,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 243, 187),
        borderRadius: BorderRadius.circular(12),
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
      child: const Text('Você tem 5 tarefas para hoje!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0))),
    );
  }

//---------------------------------------2-widget
  Widget tarefasconcluidas() {
    return Container(
      width: 160,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 253, 185, 253),
        borderRadius: BorderRadius.circular(12),
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
      child: const Text('Você já concluiu 5 tarefas hoje! Parabéns!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0))),
    );
  }
//---------------------------------------3-widget

  Widget objetivoprogeuesso() {
    return Container(
      width: 160,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 192, 156, 255),
        borderRadius: BorderRadius.circular(12),
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
      child: const Text('Dormir: 2 horas',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0))),
    );
  }
//---------------------------------------4-widget

  Widget tarefaspendetes() {
    return Container(
      width: 160,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 177, 198, 236),
        borderRadius: BorderRadius.circular(12),
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
      child: const Text('3 tarefas por fazer',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0))),
    );
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
          backgroundColor: Colors.deepPurple,
          child: Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Nome(nomeuser),
        const SizedBox(height: 10),
        Text(
          'Estamos felizes por você estar aqui! Vamos começar o seu dia?',
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
              Numtarefas(),
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
              tarefaspendetes()
            ]),
      ]),
    )));
  }
}
