import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_logs/Interface/utilizador_semlogin_page.dart';
import 'package:learn_logs/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Navegacao_page.dart';

class Checklogin extends StatefulWidget {
  const Checklogin({Key? key}) : super(key: key);

  CheckloginState createState() => CheckloginState();
}

class CheckloginState extends State<Checklogin> {
  @override
  void initState() {
    super.initState();
    verificarlogin();
  }

  Future<void> verificarlogin() async {
    final prefs = await SharedPreferences.getInstance();
    final nome = prefs.getString('nome');
    final id = prefs.getInt('id');
    await Future.delayed(const Duration(seconds: 2));
    print('Dados encontrados no SharedPreferences: nome=$nome, id=$id');
    if (nome != null && id != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Navegacao(indiceInicial: 2)),
      );
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Tela_Principal()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.flag_circle,
              color: Color.fromARGB(255, 241, 184, 97),
              size: 60,
            ),
            const SizedBox(height: 20),
            const Text(
              "LearnLogs",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 143, 33, 134),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Organize seus Estudos!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 143, 33, 134),
            ),
          ],
        ),
      ),
    );
  }
}
