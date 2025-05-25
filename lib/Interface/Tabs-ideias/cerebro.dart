import 'package:flutter/material.dart';

Widget cerebro1(BuildContext context) {
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
              Icons.brightness_auto_rounded,
              size: 30,
              color: const Color.fromARGB(255, 88, 187, 157),
            ),
            SizedBox(width: 5),
            Text(
              "Como o Cérebro Aprende Melhor",
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
              "O cérebro aprende com repetição e prática ativa. Quanto mais se pratica a 'técnica do relembrar', mais forte fica a memória.\nTécnicas como revisão espaçada e ensinar alguém são formas de ativar o cérebro e reforçar conexões.\n\nDica: Não estude só lendo! Pratique, explicando em voz alta, escrevendo ou respondendo a perguntas.",
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

Widget cerebro2(BuildContext context) {
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
              Icons.safety_check_outlined,
              size: 30,
              color: const Color.fromARGB(255, 196, 123, 186),
            ),
            SizedBox(width: 5),
            Text(
              "O Sono é o Aliado da Memória",
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
              "Enquanto se dorme, o cérebro reorganiza e armazena o que aprendeu. Quando estudamos com sono e/ou cansaço podem surgir dificuldades de raciocínio, assim como lapsos de memória.\nO ideal é dormir bem e evitar estudar durante a noite.\n\nDica: Faça uma breve revisão antes de dormir — o cérebro vai consolidar as aprendizagens durante o sono.",
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

Widget cerebro3(BuildContext context) {
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
              Icons.flutter_dash_outlined,
              size: 30,
              color: const Color.fromARGB(255, 99, 90, 231),
            ),
            SizedBox(width: 5),
            Text(
              "Dopamina e Motivação",
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
              "A dopamina é o “neurotransmissor da motivação”. Quando se cumpre um objetivo ou há um progresso, o seu cérebro liberta dopamina, contribuindo assim para um maior bem-estar.\nPor isso, é importante dividir grandes objetivos em pequenas tarefas visíveis.\n\nDica: Use o seu progresso no app como incentivo! Cada objetivo concluído ativa o seu sistema de recompensa natural.",
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

class FuncionamentoCerebroTab extends StatelessWidget {
  const FuncionamentoCerebroTab({super.key});
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
                cerebro1(context),
                cerebro2(context),
                cerebro3(context),
              ],
            ),
          )),
    );
  }
}
