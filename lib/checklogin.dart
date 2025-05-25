import 'package:flutter/material.dart';
import 'package:learn_logs/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Navegacao_page.dart';

class Checklogin extends StatefulWidget {
  const Checklogin({super.key});
  @override
  CheckloginState createState() => CheckloginState();
}

class CheckloginState extends State<Checklogin> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => verificarlogin());
  }

  Future<void> verificarlogin() async {
    final prefs = await SharedPreferences.getInstance();
    final nome = prefs.getString('nome');
    final id = prefs.getInt('id');

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    if (nome != null && id != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Navegacao(indiceInicial: 2)),
      );
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const TelaPrincipal()));
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
            Icon(
              Icons.flag_circle,
              color: Color.fromARGB(255, 241, 184, 97),
              size: 60,
            ),
            SizedBox(height: 20),
            Text(
              "LearnLogs",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 143, 33, 134),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Organize seus Estudos!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              color: Color.fromARGB(255, 143, 33, 134),
            ),
          ],
        ),
      ),
    );
  }
}
