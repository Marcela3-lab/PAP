import 'package:flutter/material.dart';
import 'package:learn_logs/Interface/Tabs-ideias/bemestar.dart';
import 'package:learn_logs/Interface/Tabs-ideias/cerebro.dart';
import 'package:learn_logs/Interface/Tabs-ideias/estudo.dart';
import 'package:learn_logs/Interface/Tabs-ideias/objetivos.dart';
import 'package:learn_logs/Interface/Tabs-ideias/tempo.dart';

class Sugestoes extends StatefulWidget {
  const Sugestoes({super.key});
  @override
  SugestoesState createState() => SugestoesState();
}

class SugestoesState extends State<Sugestoes> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dicas e Técnicas"),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "🏁 Objetivos"),
              Tab(text: "📖 Estudo"),
              Tab(text: "🧠 Cérebro"),
              Tab(text: "⏱️ Tempo"),
              Tab(text: "🌞Bem-estar"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ObjetivosTab(),
            TecnicasDeEstudoTab(),
            FuncionamentoCerebroTab(),
            GestaoTempoTab(),
            BemestarTab(),
          ],
        ),
      ),
    );
  }
}
