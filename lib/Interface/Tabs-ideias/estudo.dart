import 'package:flutter/material.dart';

Widget estudo1(BuildContext context) {
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
              Icons.widgets,
              size: 30,
              color: Colors.red,
            ),
            SizedBox(width: 10),
            Text(
              "Técnica Pomodoro",
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
              "1️⃣ Crie uma lista de objetivos por ordem de importância\n2️⃣ Ajuste um temporizador para 25 minutos\n3️⃣ Trabalhe num objetivo no tempo estabelecido\n4️⃣ Faça um intervalo de 5 minutos\n5️⃣ Depois de quatro pomodoros, faça um intervalo de 15 a 30 minutos ",
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

Widget estudo2(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 340,
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
              Icons.integration_instructions,
              size: 30,
              color: const Color.fromARGB(255, 69, 132, 228),
            ),
            SizedBox(width: 10),
            Text(
              "Prática Intercalada",
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
              "1️⃣ Escolha um assunto de estudo\n2️⃣ Divida este assunto em vários tópicos.\nComo exemplo, em Matemática podemos utilizar os tópicos: Fração, Polinómios...\n3️⃣ Faça intervalos durante cada tópico\n4️⃣ Dica: Defina os seus objetivos da mesma categoria, utilizando a mesma cor",
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

Widget estudo3(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 310,
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
              Icons.color_lens,
              size: 30,
              color: const Color.fromARGB(255, 231, 90, 196),
            ),
            SizedBox(width: 10),
            Text(
              "Memorização Visual com Cores",
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
              "1️⃣ Atribua cores a conceitos ou categorias\n2️⃣ Adicione o conteúdo que prescisa relembrar\n3️⃣ Tente memorizar o conteúdo com base na cor\n4️⃣ Dica: Utilize a descrição do objetivo para adicionar o conteúdo\n5️⃣ Dica: Defina o titulo e a cor\n",
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

class TecnicasDeEstudoTab extends StatelessWidget {
  const TecnicasDeEstudoTab({super.key});
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
                estudo1(context),
                estudo2(context),
                estudo3(context),
              ],
            ),
          )),
    );
  }
}
