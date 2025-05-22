import 'package:flutter/material.dart';
import 'package:learn_logs/Interface/Home_page.dart';
import 'package:learn_logs/Navegacao_page.dart';
import 'package:learn_logs/Provider/retornardados_provider.dart';
import 'package:learn_logs/Provider/verificaruser.dart';
import 'package:provider/provider.dart';
import 'package:learn_logs/Interface/utilizador_logado_page.dart';
import 'package:learn_logs/Provider/utilizador_semlogin_provider.dart';
import 'package:email_validator/email_validator.dart';

//Função principal pra inicial o aplicativo, que no caso se chama MyApp

//Define uma classe
class UtilizadorSemlogin extends StatefulWidget {
  const UtilizadorSemlogin({super.key});

  @override
  State<UtilizadorSemlogin> createState() => UtilizadorSemloginState();
}

class UtilizadorSemloginState extends State<UtilizadorSemlogin> {
  final formchave = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nome = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController senha = TextEditingController();
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromARGB(246, 255, 238, 212),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Form(
              key: formchave,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  const Text("Criar Conta",
                      style: TextStyle(
                        fontSize: 30,
                        color: const Color.fromARGB(255, 143, 33, 134),
                        letterSpacing: 1.5,
                      )),
                  const SizedBox(height: 40),
                  const Text("Digite seus dados para criar sua conta",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 143, 33, 134),
                        letterSpacing: 1.5,
                      )),
                  const SizedBox(height: 50),

                  //--nome
                  TextFormField(
                    controller: nome,
                    decoration: const InputDecoration(
                      labelText: "Nome de Utilizador",
                      prefixIcon: Icon((Icons.person),
                          color: Color.fromARGB(255, 0, 0, 0)),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      filled: true,
                      fillColor: (Color.fromARGB(255, 255, 255, 255)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um Nome válido';
                      } else if (value.length < 3) {
                        return 'Nome inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //-----email
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon((Icons.email),
                          color: Color.fromARGB(255, 0, 0, 0)),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um email válido';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //--senha
                  TextFormField(
                    controller: senha,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite uma senha';
                      } else if (value.length < 6) {
                        return 'Digite uma senha com mais de 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: largura * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 143, 33, 134),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      onPressed: () async {
                        if (formchave.currentState!.validate()) {
                          final dados = await Provider.of<Verificaruser>(
                                  context,
                                  listen: false)
                              .buscarnome(context, nome.text);
                          if (dados == true) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text('Nome Inválido'),
                                      content: Text(
                                          'Este nome de utilizador já existe'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Fecha o dialog
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ]);
                                });
                            return;
                          } else {
                            await Provider.of<UtilizadorSemloginProvider>(
                                    context,
                                    listen: false)
                                .enviarDados(
                                    nome.text.trim(),
                                    email.text.trim(),
                                    senha.text.trim(),
                                    context);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => Navegacao(
                                indiceInicial: 2,
                              ),
                            ));
                          }
                        }
                      },
                      child: const Text("Criar Conta"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: largura * 0.9,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 143, 33, 134),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Utilizadorlogado()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text("Iniciar Sessão"))),
                ],
              ),
            ),
          ),
        ));
  }
}
