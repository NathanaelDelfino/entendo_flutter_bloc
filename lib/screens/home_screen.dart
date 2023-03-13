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
                  RecarregaFiltro(context, TodosFiltro.all);
                  break;
                case 1:
                  RecarregaFiltro(context, TodosFiltro.pendente);
                  break;
                case 2:
                  RecarregaFiltro(context, TodosFiltro.completada);
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
            _todos('Todas', TodosFiltro.all),
            _todos('Pendentes', TodosFiltro.pendente),
            _todos('Completas', TodosFiltro.completada),
          ],
        ),
      ),
    );
  }

  RecarregaFiltro(BuildContext context, TodosFiltro filtro) {
    BlocProvider.of<TodosFiltroBloc>(context)
        .add(TodosFiltroAtualiza(filtroDeTodos: filtro));
  }

  BlocConsumer<TodosFiltroBloc, TodosFiltroState> _todos(
      String titulo, TodosFiltro filtro) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<TodosFiltroBloc, TodosFiltroState>(
      listener: (context, state) {
        if (state is TodosFiltroCarregado) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.todosFiltrados.length} tarefas',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          );
        }
      },
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
                  Container(
                    height: size.height * 0.65,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.todosFiltrados.length,
                            itemBuilder: (BuildContext context, index) {
                              return CardParaFazer(
                                  todo: state.todosFiltrados[index],
                                  atualizarTarefa: () =>
                                      RecarregaFiltro(context, filtro));
                            },
                          ),
                        ],
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
