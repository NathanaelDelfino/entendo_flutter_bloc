import 'package:entendo_flutter_bloc/blocs/todos/todos_bloc.dart';
import 'package:entendo_flutter_bloc/blocs/todos_filtro/todos_filtro_bloc.dart';
import 'package:entendo_flutter_bloc/components/card_para_fazer.dart';
import 'package:entendo_flutter_bloc/models/todos_filtro_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Entendo BLoC com Flutter'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTodoScreen(),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            onTap: (tabIndex) {
              switch (tabIndex) {
                case 0:
                  BlocProvider.of<TodosFiltroBloc>(context).add(
                      const TodosFiltroAtualiza(
                          filtroDeTodos: TodosFiltro.all));
                  break;
                case 1:
                  BlocProvider.of<TodosFiltroBloc>(context).add(
                      const TodosFiltroAtualiza(
                          filtroDeTodos: TodosFiltro.pendente));
                  break;
                case 2:
                  BlocProvider.of<TodosFiltroBloc>(context).add(
                      const TodosFiltroAtualiza(
                          filtroDeTodos: TodosFiltro.completada));
                  break;
                default:
              }
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.pending),
              ),
              Tab(
                icon: Icon(Icons.hourglass_top),
              ),
              Tab(
                icon: Icon(Icons.add_task),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _todos('Todas'),
            _todos('Pendentes'),
            _todos('Completas'),
          ],
        ),
      ),
    );
  }

  BlocBuilder<TodosFiltroBloc, TodosFiltroState> _todos(String titulo) {
    return BlocBuilder<TodosFiltroBloc, TodosFiltroState>(
      builder: (context, state) {
        if (state is TodosFiltroCarregando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TodosFiltroCarregado) {
          return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 550,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.todosFiltrados.length,
                        itemBuilder: (BuildContext context, index) {
                          return CardParaFazer(
                              todo: state.todosFiltrados[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ));
        } else {
          return const Center(
            child: Text('Erro desconhecido'),
          );
        }
      },
    );
  }
}
