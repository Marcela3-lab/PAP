import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interface/cronometro.dart';
import 'package:flutter_application_1/Interface/objetivos.dart';
import 'package:flutter_application_1/Interface/calendario.dart';
import 'package:flutter_application_1/Interface/sugestoes.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_application_1/Login/Ultilizador_semlogin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _opcaoselecionada = 0;

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
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const UltilizadorSemlogin()),
                );
              }),
        ],
      )),
      body: IndexedStack(
        index: _opcaoselecionada,
        children: const <Widget>[
          Cronometro(),
          Calendario(),
          Objetivos(),
          Sugestoes(),
        ],
      ),
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
          TabItem(icon: Icons.hourglass_bottom_outlined, title: 'Plano'),
          TabItem(icon: Icons.edit_calendar, title: 'Agenda'),
          TabItem(icon: Icons.flag, title: 'Objetivos'),
          TabItem(icon: Icons.fact_check, title: 'Sugestões'),
        ],
      ),
    );
  }
}
