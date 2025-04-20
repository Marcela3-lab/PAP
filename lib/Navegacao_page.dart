import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interface/Progresso.dart';
import 'package:flutter_application_1/Interface/calendario_page.dart';
import 'package:flutter_application_1/Interface/sugestoes_page.dart';
import 'package:flutter_application_1/Interface/Home_page.dart';
import 'package:flutter_application_1/Interface/objetivos_page.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_application_1/main.dart';

class Navegacao extends StatefulWidget {
  final String nomeuser;
  final bool primeiroacesso;
  const Navegacao(
      {super.key, required this.nomeuser, required this.primeiroacesso});

  @override
  _NavegacaoState createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  int _opcaoselecionada = 2;

  late List<Widget> _telas;
  @override
  void initState() {
    super.initState();
    _telas = [
      Calendario(),
      Progresso(),
      Home(nomeuser: widget.nomeuser, primeiroacesso: widget.primeiroacesso),
      Objetivos(),
      Sugestoes(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(120, 235, 221, 245),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 192, 156, 255),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
          ListTile(
              leading: const Icon(Icons.exit_to_app, size: 30),
              iconColor: const Color.fromARGB(255, 192, 156, 255),
              title: const Text('Sair'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const Tela_Principal()),
                );
              }),
        ],
      )),
      body: _telas[_opcaoselecionada],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color.fromARGB(255, 192, 156, 255),
        color: Colors.white,
        activeColor: const Color.fromARGB(255, 255, 211, 154),
        initialActiveIndex: _opcaoselecionada,
        onTap: (index) {
          print('clicou $index');
          setState(() {
            _opcaoselecionada = index;
          });
        },
        items: const [
          TabItem(icon: Icons.edit_calendar, title: 'Agenda'),
          TabItem(icon: Icons.hourglass_bottom_outlined, title: 'Progresso'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.flag, title: 'Objetivos'),
          TabItem(icon: Icons.fact_check, title: 'Sugestões'),
        ],
      ),
    );
  }
}
