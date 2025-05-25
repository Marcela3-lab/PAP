import 'package:flutter/material.dart';

Widget obj1(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 380,
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
    padding: const EdgeInsets.symmetric(vertical: 11),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromARGB(255, 250, 244, 191), Color(0xFFFFEAF1)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 140, 98, 189).withAlpha(51),
          spreadRadius: 2,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.keyboard_command_key,
              size: 30,
              color: const Color.fromARGB(255, 228, 74, 228),
            ),
            SizedBox(width: 5),
            Text(
              "Como definir objetivos",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Adicione os objetivos de estudo que deseja alcançar e acompanhe o seu progresso! \n\nCada objetivo pode ter uma descrição personalizada, podendo assim escrever mais detalhes sobre aquele — como o que exatamente precisa de ser feito ou qual o prazo de conclusão. Pode vizualizar a descrição sempre que quiser, clicando no botão de detalhes na própria caixa do objetivo.",
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(221, 0, 0, 0),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    ),
  );
}

Widget obj2(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 290,
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
    padding: const EdgeInsets.symmetric(vertical: 11),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromARGB(255, 250, 244, 191), Color(0xFFFFEAF1)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 140, 98, 189).withAlpha(51),
          spreadRadius: 2,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.cloud,
              size: 30,
              color: const Color.fromARGB(255, 130, 123, 196),
            ),
            SizedBox(width: 5),
            Text(
              "Como usar as cores",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Pode atribuir uma cor ao seu objetivo com base numa nota de 1 a 10. Cada nota está associada a uma cor diferente: \n\n🟢 1 a 4 → Cor verde\n🟡 5 a 7 → Cor amarela\n🔴 8 a 10 → Cor vermelha",
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(221, 0, 0, 0),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    ),
  );
}

Widget obj3(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 350,
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
    padding: const EdgeInsets.symmetric(vertical: 11),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromARGB(255, 250, 244, 191), Color(0xFFFFEAF1)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 140, 98, 189).withAlpha(51),
          spreadRadius: 2,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.gesture_sharp,
              size: 30,
              color: const Color.fromARGB(255, 62, 204, 192),
            ),
            SizedBox(width: 5),
            Text(
              "Ideias de organização",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "🏷️ Importância:\nUse notas maiores para objetivos mais urgentes.\n🧩 Categoria dos objetivos:\nComo exemplo poderá usar a mesma cor para objetivos de categorias semelhantes.\n🎯 Associação de conteúdo pela cor:\nExemplo - Todos os objetivos verdes estão relacionados com um tópico especifico da disciplina de História. ",
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(221, 0, 0, 0),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    ),
  );
}

class ObjetivosTab extends StatelessWidget {
  const ObjetivosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          margin: EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                obj1(context),
                obj2(context),
                obj3(context)
              ],
            ),
          )),
    );
  }
}
