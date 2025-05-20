import 'package:flutter/material.dart';
import 'package:learn_logs/Interface/objetivos_page.dart';
import 'package:learn_logs/Navegacao_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:learn_logs/Provider/Adicionarobjetivo_Provider.dart';

class PObjetivo extends StatefulWidget {
  const PObjetivo({super.key});
  @override
  _PObjetivoState createState() => _PObjetivoState();
}

class _PObjetivoState extends State<PObjetivo> {
  final TextEditingController _titulo = TextEditingController();

  final TextEditingController _descricao = TextEditingController();
  final TextEditingController _meta = TextEditingController();
  final TextEditingController _cor = TextEditingController();
  String? tipo;

  List<String> listatipometa = ['Horas', 'Minutos'];
  Color corobjetivo(int cor) {
    if (cor >= 8 && cor <= 10) {
      return Colors.red.shade200;
    } else if (cor >= 1 && cor <= 4) {
      return Colors.orange.shade200;
    } else if (cor >= 5 && cor <= 7) {
      return Colors.green.shade200;
    } else {
      return Color.fromARGB(255, 255, 255, 255);
    }
  }

  Widget dropdown() {
    return (Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: 139,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color.fromARGB(255, 139, 134, 134),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButton<String>(
              hint: Text(
                '  Tipo',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              value: tipo,
              style: TextStyle(
                color: const Color.fromARGB(255, 192, 156, 255),
                fontSize: 16,
              ),
              underline: SizedBox(),
              isExpanded: true,
              items: listatipometa.map((String item) {
                return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ));
              }).toList(),
              onChanged: (String? novotipo) {
                setState(() {
                  print(novotipo);
                  tipo = novotipo;
                });
              },
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.purple.shade700,
              ),
            ),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(backgroundColor: Color.fromARGB(255, 240, 228, 255)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Adicionar Objetivo',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 143, 33, 134),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //PASSAR A COR PARA OUTRA TELA

            SizedBox(height: 0),
            _Pergunta(_titulo, _descricao, _meta, _cor),
            SizedBox(height: 30),
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
                    )),
                onPressed: () async {
                  int corDigitada = int.tryParse(_cor.text) ?? 0;
                  int duracaoconver = int.tryParse(_meta.text) ?? 0;

                  corobjetivo(corDigitada);

                  bool duracaovalida = await context
                      .read<AdicionarobjetivoProvider>()
                      .verificarduracao(context, duracaoconver);

                  bool camposvalidos = await context
                      .read<AdicionarobjetivoProvider>()
                      .verificarcampos(context, _titulo.text, _descricao.text,
                          _meta.text, tipo);
                  if (duracaovalida && camposvalidos) {
                    context.read<AdicionarobjetivoProvider>().adicionarobjetivo(
                          context,
                          _titulo.text,
                          _descricao.text,
                          _meta.text,
                          tipo,
                          _cor.text,
                        );

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Navegacao(
                          indiceInicial: 1,
                        ),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
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
      TextEditingController meta,
      TextEditingController cor) {
    return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 251, 255, 235),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
              text: TextSpan(
            text: 'Título: ',
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
            controller: _titulo,
            decoration: InputDecoration(
              hintText: 'Digite o título do objetivo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Descrição:',
            style: TextStyle(fontSize: 16),
          ),
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
          RichText(
              text: TextSpan(
            text: 'Duração: ',
            style: TextStyle(
                color: const Color.fromARGB(255, 78, 71, 71), fontSize: 16),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          )),
          Row(children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 149, maxHeight: 50),
              child: TextFormField(
                controller: _meta,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Digite o número de horas ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            dropdown(),
          ]),
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Ajuda"),
                      content: Text(
                          "🟢 1 a 4 → Cor verde\n🟡 5 a 7 → Cor amarela\n🔴 8 a 10 → Cor vermelha"),
                      actions: [
                        TextButton(
                          child: Text("Ok"),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                  );
                },
                child: const Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Color.fromARGB(255, 11, 71, 150),
                ),
              ),
              const SizedBox(width: 4),
              const Text('Digite a cor do seu objetivo:',
                  style: TextStyle(fontSize: 16)),
            ],
          ),
          TextFormField(
            controller: _cor,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'De 1 a 10 ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ]));
  }
}
