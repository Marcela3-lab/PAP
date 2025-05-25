import 'package:flutter/material.dart';

Widget tempo1(BuildContext context) {
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
              Icons.rule,
              size: 30,
              color: const Color.fromARGB(255, 207, 66, 66),
            ),
            SizedBox(width: 5),
            Text(
              "O Cérebro Gosta de Organização",
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
              "Quando organiza a sua rotina, isto é entendido pelo cérebro como importante. Ter horários definidos reduz o stresse e aumenta a produtividade, porque o cérebro funciona melhor quando sabe o que esperar.\n\nDica: Use a agenda para marcar os seus horários de estudo e outras tarefas e siga uma rotina bem planeada, mas constante.",
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

Widget tempo2(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 390,
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
          color: const Color.fromARGB(255, 140, 98, 189).withAlpha(52),
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
              Icons.punch_clock,
              size: 30,
              color: const Color.fromARGB(255, 124, 196, 42),
            ),
            SizedBox(width: 5),
            Text(
              "Priorize o Mais Importante",
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
              "O cérebro gasta mais energia com tarefas difíceis. Se  deixar o mais difícil para o fim do dia, vai sentir mais cansaço e propensão à desistência. Estudar o mais importante ajuda a economizar energia mental.\n\nDica: Defina 1 ou 2 objetivos principais para o dia. Com isto, já terá feito o essencial. Lembre-se de olhar a Home para ver um resumo do seu dia.",
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

Widget tempo3(BuildContext context) {
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
              Icons.restart_alt,
              size: 30,
              color: const Color.fromARGB(255, 221, 31, 78),
            ),
            SizedBox(width: 5),
            Text(
              "Descanso Também É Produtivo",
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
              "Fazer pausas programadas ajuda o cérebro a processar melhor o conteúdo. Estudar por horas seguidas sem descanso aumenta o cansaço e diminui o rendimento. Equilibrar estudo e descanso não é preguiça — é inteligência.\n\nDica: Entre os blocos de estudo, levante, alongue-se ou tome água. Isso recarrega seu foco para o próximo ciclo.",
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

class GestaoTempoTab extends StatelessWidget {
  const GestaoTempoTab({super.key});
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
                tempo1(context),
                tempo2(context),
                tempo3(context),
              ],
            ),
          )),
    );
  }
}
