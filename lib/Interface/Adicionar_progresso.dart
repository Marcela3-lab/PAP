import 'package:flutter/material.dart';
import 'package:flutter_application_1/Provider/Adicionar_progresso.dart';
import 'package:provider/provider.dart';

class AdicionarProgresso extends StatefulWidget {
  const AdicionarProgresso({super.key});

  @override
  AdicionarProguessoState createState() => AdicionarProguessoState();
}

class AdicionarProguessoState extends State<AdicionarProgresso> {
  final TextEditingController objetivo = TextEditingController();

  final TextEditingController meta = TextEditingController();
  final TextEditingController avanco = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 137, 196),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Adicionar Progresso',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 29.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            _Pergunta(objetivo, meta, avanco),
            SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 137, 196),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 160),
                  ),
                  onPressed: () async {
                    Provider.of<AdicionarProgressoProvider>(context,
                            listen: false)
                        .adicionarProgresso(
                            context, objetivo.text, meta.text, avanco.text);
                  },
                  child: Text("Salvar"),
                )),
          ],
        )));
  }
}

Widget _Pergunta(TextEditingController objetivo, TextEditingController meta,
    TextEditingController avanco) {
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F1F1),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Obejtivo:'),
        TextFormField(
          controller: objetivo,
          decoration: InputDecoration(
            hintText: 'Digite seu objetivo',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Meta:'),
        TextFormField(
          controller: meta,
          decoration: InputDecoration(
            hintText: 'Qual é a sua meta?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Meu avanço:'),
        TextFormField(
          controller: avanco,
          decoration: InputDecoration(
            hintText: 'Digite o número de horas ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    ),
  );
}
