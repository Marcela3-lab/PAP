import 'package:flutter/material.dart';
import 'package:learn_logs/Provider/retornardados_provider.dart';
import 'package:learn_logs/checklogin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Telaconta extends StatefulWidget {
  const Telaconta({Key? key}) : super(key: key);

  @override
  TelacontaState createState() => TelacontaState();
}

class TelacontaState extends State<Telaconta> {
  Map<String, dynamic>? dadosuserj;
  @override
  void initState() {
    super.initState();
    carregardados();
  }

  Future<void> carregardados() async {
    final provider = Provider.of<RetornardadosProvider>(context, listen: false);
    List<Map<String, dynamic>> dados = await provider.buscaruserdados();

    if (dados.isNotEmpty) {
      setState(() {
        dadosuserj = dados[0];
      });
    }
    print("aaa $dados");
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 240, 228, 255),
        ),
        body: ListView(children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 228, 255),
            ),
            child: Icon(
              Icons.account_circle, // aqui você escolhe o ícone que quer
              color: const Color.fromARGB(255, 117, 16, 117),
              size: 70,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 228, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.person,
                      size: 28,
                      color: const Color.fromARGB(255, 117, 16, 117),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    dadosuserj?['nome'] ?? 'Nome não disponível',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 117, 16, 117),
                    ),
                  )
                ]),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 228, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.email,
                      size: 28,
                      color: const Color.fromARGB(255, 117, 16, 117),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    dadosuserj?['email'] ?? 'Email não disponível',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 117, 16, 117),
                    ),
                  )
                ]),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 228, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.calendar_month,
                      size: 28,
                      color: const Color.fromARGB(255, 117, 16, 117),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    dadosuserj?['datad'] ?? 'Data de login não disponivel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 117, 16, 117),
                    ),
                  )
                ]),
              ))
        ]));
  }
}
