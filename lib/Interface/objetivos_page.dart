import 'package:flutter/material.dart';
import 'package:learn_logs/Interface/adicionar_obejtivo.dart';
import 'package:learn_logs/Provider/objetivo_provider.dart';
import 'package:provider/provider.dart';

class Objetivos extends StatefulWidget {
  const Objetivos({super.key});

  Widget centralizartexto() {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flag,
              size: 40,
              color: Color.fromARGB(255, 143, 33, 134),
            ),
            Center(
              child: const Text(
                "Objetivos",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ));
  }

  @override
  ObjetivosState createState() => ObjetivosState();
  Widget objetivo(BuildContext context, String id, String titulo, Color cor,
      Function atualizarLista, descricao, meta, tipometa) {
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
            color: Colors.grey.withAlpha(120),
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
            icon:
                const Icon(Icons.delete, color: Color.fromARGB(255, 201, 1, 1)),
            onPressed: () async {
              await Provider.of<ObjetivoProvider>(context, listen: false)
                  .deletarObjetivo(id);
              atualizarLista();
            },
          ),
          IconButton(
              icon: const Icon(Icons.more_horiz,
                  color: Color.fromARGB(255, 23, 10, 143)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text('Detalhes',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          content: Text(
                            "Descrição: $descricao\nMeta: $meta $tipometa",
                            style: TextStyle(fontSize: 15),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Fechar'),
                            ),
                          ]);
                    });
              }),
        ],
      ),
    );
  }
}

class ObjetivosState extends State<Objetivos> {
  late Future<List<Map<String, dynamic>>> lista = Future.value([]);
  @override
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
            const SizedBox(height: 20),
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
                    final dados = snapshot.data!;
                    return ListView(
                      children: dados.map((item) {
                        return widget.objetivo(
                            context,
                            item['id_objetivo'],
                            item['titulo'],
                            item['cor'],
                            atualizarLista,
                            item['descricao'],
                            item['meta'],
                            item['tipo']);
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 167, 211),
                    foregroundColor: const Color.fromARGB(255, 82, 9, 124),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PObjetivo(),
                    ),
                  );
                },
                child: const Text('Adicionar Objetivo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
