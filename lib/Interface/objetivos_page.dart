import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interface/Adicionar_obejtivo.dart';
import 'package:flutter_application_1/Provider/objetivo_provider.dart';
import 'package:provider/provider.dart';

class Objetivos extends StatefulWidget {
  Widget centralizartexto() {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          "Objetivos",
          style: TextStyle(fontSize: 25),
        ));
  }

  @override
  _ObjetivosState createState() => _ObjetivosState();
  // OBJETIVO------------------------------------------------------------
  Widget objetivo(BuildContext context, String id, String titulo, Color cor,
      Function atualizarLista) {
    return Container(
      alignment: Alignment.center,
      width: 500,
      height: 80,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              titulo,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete,
                color: Color.fromARGB(255, 174, 103, 240)),
            onPressed: () async {
              await Provider.of<ObjetivoProvider>(context, listen: false)
                  .deletarObjetivo(id);
              atualizarLista();
            },
          ),
          IconButton(
            icon: const Icon(Icons.note_alt,
                color: Color.fromARGB(255, 78, 141, 184)),
            onPressed: () {
              String anotacao = '';
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Anotação',
                        style: TextStyle(fontSize: 20),
                      ),
                      content: TextField(
                        onChanged: (value) {
                          anotacao = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Digite sua anotação aqui',
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text("Cancelar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Salvar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          )
        ],
      ),
    );
  }
  // OBJETIVO------------------------------------------------------------
}

class _ObjetivosState extends State<Objetivos> {
  late Future<List<Map<String, dynamic>>> lista = Future.value([]);

  void initState() {
    super.initState();
    objetivocarregado();
  }

  void objetivocarregado() {
    Future.delayed(Duration.zero, () {
      setState(() {
        lista = Provider.of<ObjetivoProvider>(context, listen: false)
            .buscarobjetivos();
      });
    });
  }

  void atualizarLista() {
    setState(() {
      lista = Provider.of<ObjetivoProvider>(context, listen: false)
          .buscarobjetivos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            widget.centralizartexto(),
            Text(
              'Defina seus objetivos e acompanhe seu progresso!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            // Lista de objetivos com rolagem
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: lista,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Erro ao carregar: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text("Nenhum objetivo encontrado."));
                  } else {
                    // Dados carregados
                    final dados = snapshot.data!;
                    return ListView(
                      children: dados.map((item) {
                        return widget.objetivo(context, item['id_objetivo'],
                            item['titulo'], item['cor'], atualizarLista);
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  final novo = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PObjetivo(),
                    ),
                  );
                },
                child: const Text('Adicionar Objetivo'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 192, 156, 255)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
