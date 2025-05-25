import 'package:flutter/material.dart';
import 'package:learn_logs/Interface/Progresso.dart';
import 'package:learn_logs/Interface/calendario_page.dart';
import 'package:learn_logs/Interface/sugestoes_page.dart';
import 'package:learn_logs/Interface/home_page.dart';
import 'package:learn_logs/Interface/objetivos_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:learn_logs/Provider/sairsh_provider.dart';
import 'package:learn_logs/Provider/sairprovider.dart';
import 'package:learn_logs/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Interface/definicoes.dart';

class Navegacao extends StatefulWidget {
  final int? indiceInicial;
  const Navegacao({super.key, this.indiceInicial});

  @override
  NavegacaoState createState() => NavegacaoState();
}

class NavegacaoState extends State<Navegacao> {
  late int _opcaoselecionada;
  bool dadoscarregado = false;
  late List<Widget> _telas;
  @override
  void initState() {
    super.initState();
    _opcaoselecionada = widget.indiceInicial ?? 2;
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    final nome = prefs.getString('nome') ?? "Utilizador";

    setState(() {
      nome;

      _telas = [
        Calendario(),
        Objetivos(),
        Home(),
        Progresso(),
        Sugestoes(),
      ];
      dadoscarregado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 228, 255),
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 143, 33, 134)),
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
                color: Color.fromARGB(255, 143, 33, 134),
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
              leading: const Icon(
                Icons.delete_sweep_sharp,
              ),
              iconColor: Color.fromRGBO(94, 7, 145, 1),
              title: const Text('Apagar Conta'),
              onTap: () async {
                final confirmado =
                    await Provider.of<Sairprovider>(context, listen: false)
                        .apagaruser(context);

                if (confirmado == true) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const TelaPrincipal()),
                    );
                  }
                }
              }),
          ListTile(
            leading: Icon(Icons.badge),
            iconColor: Color.fromRGBO(94, 7, 145, 1),
            title: Text('Minha Conta'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Telaconta()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            iconColor: Color.fromRGBO(94, 7, 145, 1),
            title: Text('Sair'),
            onTap: () async {
              final conf =
                  await Provider.of<Sairshprovider>(context, listen: false)
                      .dadoslocais();

              if (conf) {
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => TelaPrincipal()),
                      (Route<dynamic> route) => false);
                }
              }
            },
          ),
        ],
      )),
      body: (!dadoscarregado)
          ? const Center(child: CircularProgressIndicator())
          : _telas[_opcaoselecionada],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color.fromARGB(255, 240, 228, 255),
        color: const Color.fromARGB(255, 143, 33, 134),
        activeColor: const Color.fromARGB(255, 180, 139, 233),
        initialActiveIndex: _opcaoselecionada,
        onTap: (index) {
          setState(() {
            _opcaoselecionada = index;
          });
        },
        items: const [
          TabItem(icon: Icons.edit_calendar, title: 'Agenda'),
          TabItem(icon: Icons.flag, title: 'Objetivos'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.hourglass_bottom_outlined, title: 'Progresso'),
          TabItem(icon: Icons.fact_check, title: 'Suporte'),
        ],
      ),
    );
  }
}
