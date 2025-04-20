import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interface/objetivos_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/Provider/Adicionarobjetivo_Provider.dart';

class PObjetivo extends StatefulWidget {
  const PObjetivo({super.key});
  @override
  _PObjetivoState createState() => _PObjetivoState();
}

class _PObjetivoState extends State<PObjetivo> {
  final TextEditingController _titulo = TextEditingController();

  final TextEditingController _descricao = TextEditingController();
  final TextEditingController _duracao = TextEditingController();
  final TextEditingController _cor = TextEditingController();

  Color corobjetivo(int cor) {
    if (cor >= 8) {
      return Colors.red.shade200;
    } else if (cor >= 5) {
      return Colors.orange.shade200;
    } else {
      return Colors.green.shade200;
    }
  }

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
                    color: Color.fromARGB(255, 177, 198, 236),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Adicionar Objetivo',
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

            //PASSAR A COR PARA OUTRA TELA

            SizedBox(height: 20),
            _Pergunta(_titulo, _descricao, _duracao, _cor),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 177, 198, 236),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 140),
                ),
                onPressed: () async {
                  int corDigitada = int.tryParse(_cor.text) ?? 0;
                  int duracaoconver = int.tryParse(_duracao.text) ?? 0;
                  corobjetivo(corDigitada);

                  bool duracaovalida = await context
                      .read<AdicionarobjetivoProvider>()
                      .verificarduracao(context, duracaoconver);

                  bool corvalida = await context
                      .read<AdicionarobjetivoProvider>()
                      .verificarcor(context, corDigitada);
                  context
                      .read<AdicionarobjetivoProvider>()
                      .verificarcor(context, corDigitada);

                  bool camposvalidos = await context
                      .read<AdicionarobjetivoProvider>()
                      .verificarcampos(context, _titulo.text, _descricao.text,
                          _duracao.text, _cor.text);
                  if (duracaovalida && corvalida && camposvalidos) {
                    context.read<AdicionarobjetivoProvider>().adicionarobjetivo(
                          context,
                          _titulo.text,
                          _descricao.text,
                          _duracao.text,
                          _cor.text,
                        );
                  }
                  _titulo.clear();
                  _descricao.clear();
                  _duracao.clear();
                  _cor.clear();
                },
                child: const Text('Salvar Tarefa'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _Pergunta(
      TextEditingController titulo,
      TextEditingController descricao,
      TextEditingController duracao,
      TextEditingController cor) {
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
          const Text('Titulo:'),
          TextFormField(
            controller: _titulo,
            decoration: InputDecoration(
              hintText: 'Digite o título do objetivo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Descrição:'),
          TextFormField(
            controller: _descricao,
            decoration: InputDecoration(
              hintText: 'Adicione uma descrição',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Meta diaria:'),
          TextFormField(
            controller: _duracao,
            decoration: InputDecoration(
              hintText: 'Digite o número de horas ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('De 1 a 10 qual a importância do seu objetivo:'),
          TextFormField(
            controller: _cor,
            decoration: InputDecoration(
              hintText: 'De 1 a 10 ',
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
