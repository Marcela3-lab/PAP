import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/Provider/AdicionarTarefa_provider.dart';

class PAgenda extends StatefulWidget {
  final String nome;
  PAgenda({required this.nome});

  @override
  _PAgendaState createState() => _PAgendaState();
}

class _PAgendaState extends State<PAgenda> {
  final TextEditingController _inicio = TextEditingController();
  final TextEditingController _fim = TextEditingController();
  final TextEditingController _titulo = TextEditingController();

//converte hora pro formato que da pra verificar
  DateTime converterHora(String hora) {
    String hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String horaeData = "$hoje $hora";
    return DateFormat("yyyy-MM-dd HH:mm").parse(horaeData);
  }

//---------------------------- INICIO DESIGN ----------------------------//
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AdicionartarefaProvider>(context, listen: false);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
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
                    color: Color.fromARGB(255, 192, 156, 255),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.nome}',
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
            _Pergunta(_titulo, _inicio, _fim),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 192, 156, 255),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 140),
                ),
                onPressed: () async {
                  final titulo = _titulo.text;
                  final inicio = _inicio.text;
                  final fim = _fim.text;
                  if (await provider.verificarcamposagenda(
                      context, titulo, inicio, fim)) {
                    provider.enviarTarefa(
                      context,
                      titulo,
                      inicio,
                      fim,
                      widget.nome,
                    );
                  }
                  _titulo.clear();
                  _inicio.clear();
                  _fim.clear();
                },
                child: const Text('Salvar Tarefa'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _Pergunta(TextEditingController titulo, TextEditingController inicio,
      TextEditingController fim) {
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
          const Text('Tarefa:'),
          TextFormField(
            controller: titulo,
            decoration: InputDecoration(
              hintText: 'Digite o título da tarefa',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Hora de Início:'),
          TextFormField(
            controller: inicio,
            decoration: InputDecoration(
              hintText: 'HH:mm',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Hora de Fim:'),
          TextFormField(
            controller: fim,
            decoration: InputDecoration(
              hintText: 'HH:mm',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
