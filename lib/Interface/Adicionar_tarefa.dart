import 'package:flutter/material.dart';
import 'package:learn_logs/Navegacao_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:learn_logs/Provider/adicionartarefa_provider.dart';

class PAgenda extends StatefulWidget {
  final String? nome;

  const PAgenda({super.key, required this.nome});

  @override
  PAgendaState createState() => PAgendaState();
}

class PAgendaState extends State<PAgenda> {
  final TextEditingController _inicio = TextEditingController();
  final TextEditingController _fim = TextEditingController();
  final TextEditingController _titulo = TextEditingController();

  DateTime converterHora(String hora) {
    String hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String horaeData = "$hoje $hora";
    return DateFormat("yyyy-MM-dd HH:mm").parse(horaeData);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<Adicionartarefaprovider>(context, listen: false);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(backgroundColor: Color.fromARGB(255, 240, 228, 255)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${widget.nome}',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 143, 33, 134),
                            fontSize: 29.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pergunta(_titulo, _inicio, _fim),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 167, 211),
                      foregroundColor: const Color.fromARGB(255, 82, 9, 124),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 140,
                      ),
                    ),
                    onPressed: () async {
                      final titulo = _titulo.text;
                      final inicio = _inicio.text;
                      final fim = _fim.text;
                      if (await provider.verificarcamposagenda(
                          context, titulo, inicio, fim)) {
                        if (context.mounted) {
                          await provider.enviarTarefa(
                            context,
                            titulo,
                            inicio,
                            fim,
                            widget.nome!,
                          );

                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Navegacao(
                                  indiceInicial: 0,
                                ),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        }
                      }
                    },
                    child: const Text('Salvar Tarefa'),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget pergunta(TextEditingController titulo, TextEditingController inicio,
      TextEditingController fim) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 251, 255, 235),
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
          RichText(
              text: TextSpan(
            text: 'Tarefa: ',
            style: TextStyle(
                color: const Color.fromARGB(255, 78, 71, 71), fontSize: 16),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          )),
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
          RichText(
              text: TextSpan(
            text: 'Hora de Início: ',
            style: TextStyle(
                color: const Color.fromARGB(255, 78, 71, 71), fontSize: 16),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          )),
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
          RichText(
              text: TextSpan(
            text: 'Hora de Fim: ',
            style: TextStyle(
                color: const Color.fromARGB(255, 78, 71, 71), fontSize: 16),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          )),
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
