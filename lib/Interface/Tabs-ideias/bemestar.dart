import 'package:flutter/material.dart';

Widget bemestar1(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 400,
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
              Icons.heart_broken,
              size: 30,
              color: const Color.fromARGB(255, 202, 66, 207),
            ),
            SizedBox(width: 5),
            Text(
              "Estudar com Ansiedade Não\nFunciona",
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
              "Quando você está muito ansioso, o cérebro foca no problema, não no conteúdo. Isso atrapalha a memorização e o foco. Fazer pausas, respirar fundo e aceitar seus limites ajuda mais do que esforçar-se excessivamente.\n\nDica: Se estiver ansioso, faça uma respiração profunda (4 segundos inspirando, 4 prendendo, 4 expirando). Repita 3 vezes e só então retome.",
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

Widget bemestar2(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 320,
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
              Icons.tag_faces,
              size: 30,
              color: const Color.fromARGB(255, 223, 185, 62),
            ),
            SizedBox(width: 5),
            Text(
              "Celebre Pequenas Conquistass",
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
              "O cérebro precisa de recompensas para manter o esforço. Quando você comemora um objetivo concluído, mesmo que pequeno, ativa seu sistema de motivação e sente mais vontade de continuar.\n\nDica: Terminou um Pomodoro ou atingiu seu objetivo? Faça algo que te faça bem — uma música, um lanche, uma pausa feliz.",
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

Widget bemestar3(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 300,
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
              Icons.face_6_sharp,
              size: 30,
              color: const Color.fromARGB(255, 23, 64, 153),
            ),
            SizedBox(width: 5),
            Text(
              " Comparação Só Desanima",
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
              "Cada cérebro tem seu ritmo. Comparar o seu progresso com o dos outros causa frustração e bloqueios. O foco deve ser em melhorar em relação a você mesma, não aos outros.\n\nDica: O seu progresso em relação a si mesmo é o que importa",
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

class BemestarTab extends StatelessWidget {
  const BemestarTab({super.key});
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
                bemestar1(context),
                bemestar2(context),
                bemestar3(context),
              ],
            ),
          )),
    );
  }
}
