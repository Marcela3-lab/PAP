import 'package:flutter/material.dart';
import 'package:flutter_application_1/Login/ultilizador_logado.dart';
import 'package:http/http.dart' as http;

//Função principal pra inicial o aplicativo, que no caso se chama MyApp

//Define uma classe
class UltilizadorSemlogin extends StatelessWidget {
  const UltilizadorSemlogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Login",
      home: RegistroPage(),
    );
  }
}

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  Future<void> enviarDados() async {
    const String url = "http://192.168.1.71/index.php";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'nome': _nome.text,
          'email': _email.text,
          'senha': _senha.text,
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Erro"),
                  content:
                      Text("Erro ao enviar os dados. ${response.statusCode}"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Ok"))
                  ],
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Erro"),
                content: Text("Não foi possivel conectar ao servidor. $e"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Certifique-se de que o MaterialApp é o widget raiz
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 178, 202),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Criar Conta",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Raleway",
                    color: Color.fromARGB(255, 255, 255, 255),
                    letterSpacing: 1.5,
                  )),
              const SizedBox(height: 30),
              const Text("Digite seus dados para criar sua conta",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  )),
              const SizedBox(height: 80),
              //--nome
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(
                  labelText: "Nome de Utilizador",
                  prefixIcon:
                      Icon((Icons.person), color: Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  filled: true,
                  fillColor: (Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              const SizedBox(height: 20),

              //-----email
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon:
                      Icon((Icons.email), color: Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                ),
              ),
              const SizedBox(height: 20),

              //--senha
              TextFormField(
                controller: _senha,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  prefixIcon: Icon((Icons.password),
                      color: Color.fromARGB(255, 0, 0, 0)),
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: (Color.fromARGB(255, 255, 255, 255)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(221, 255, 167, 51),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 143),
                ),
                onPressed: () {
                  enviarDados();
                },
                child: const Text("Criar Conta"),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(221, 255, 219, 173),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 130),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const UltilizadorLogado()),
                  );
                },
                child: const Text("Já tenho conta"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
