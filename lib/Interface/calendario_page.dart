import 'package:flutter/material.dart';
import 'package:learn_logs/Interface/Adicionar_tarefa.dart';
import 'package:learn_logs/Provider/AdicionarTarefa_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:learn_logs/Provider/calendario_provider.dart';

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  CalendarFormat _calendarioFormato = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  String? formattedDate;
  final int _opcaoselecionada = 0;

  @override
  void initState() {
    super.initState();
    _selectedDay ??= DateTime.now();
    formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDay!);

    Future.microtask(() {
      final calendarioProvider =
          Provider.of<CalendarioProvider>(context, listen: false);
      calendarioProvider.carregarEventos(_selectedDay!);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  Widget build(BuildContext contex) {
    final calendarioProvider = Provider.of<CalendarioProvider>(context);
    final eventos = calendarioProvider.eventos;
    final tarefaconcluidaProvider =
        Provider.of<AdicionartarefaProvider>(context, listen: false);
    bool concluida = false;

    return Scaffold(
      body: IndexedStack(
        index: _opcaoselecionada,
        children: <Widget>[
          Column(
            children: [
              TableCalendar(
                  locale: 'pt_PT',
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2024, 1, 1),
                  lastDay: DateTime(2030, 12, 31),
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarioFormato = format;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      formattedDate =
                          DateFormat('dd-MM-yyyy').format(selectedDay);
                    });

                    Provider.of<CalendarioProvider>(context, listen: false)
                        .carregarEventos(selectedDay);
                  },
                  //Não trava
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(color: Colors.white),
                    todayDecoration: BoxDecoration(
                      color: Color.fromARGB(148, 182, 103, 212),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    selectedDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 120, 5, 173),
                      shape: BoxShape.circle,
                    ),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 167, 211),
                    foregroundColor: const Color.fromARGB(255, 82, 9, 124),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () async {
                  print("Há um erro muito grande aqui! $formattedDate");

                  final resultado = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PAgenda(nome: formattedDate!),
                    ),
                  );
                  if (resultado == true) {
                    Provider.of<CalendarioProvider>(context, listen: false)
                        .carregarEventos(_selectedDay!);
                    setState(() {});
                  }
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 20),
              eventos.isEmpty
                  ? Text("Nenhum evento encontrado para esta data")
                  : Expanded(
                      child: ListView.builder(
                        itemCount: eventos.length,
                        itemBuilder: (context, index) {
                          final evento = eventos[index];

                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 128, 17, 143),
                              ),
                              color: evento["estado"] == "concluida"
                                  ? const Color.fromARGB(255, 206, 247, 208)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(evento["titulo"]),
                                  subtitle: Text(
                                    "Início: ${evento["inicio"]} - Fim: ${evento["fim"]}",
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.check,
                                    color: Color.fromARGB(255, 15, 168, 15)),
                                onPressed: () async {
                                  concluida = true;
                                  print(
                                      'Estado: ${(concluida) ? 'concluida' : 'pendente'}');

                                  await tarefaconcluidaProvider.estado(
                                      concluida,
                                      int.parse(evento["id_agenda"]));

                                  if (mounted) {
                                    Provider.of<CalendarioProvider>(context,
                                            listen: false)
                                        .carregarEventos(_selectedDay!);

                                    setState(() {});
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Color.fromARGB(255, 206, 16, 16)),
                                onPressed: () async {
                                  await tarefaconcluidaProvider.deletartarefa(
                                      int.parse(evento["id_agenda"]));
                                  Provider.of<CalendarioProvider>(context,
                                          listen: false)
                                      .carregarEventos(_selectedDay!);

                                  setState(() {});
                                },
                              )
                            ]),
                          );
                        },
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
