import 'package:entendo_flutter_bloc/blocs/todos/todos_bloc.dart';
import 'package:entendo_flutter_bloc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/todos_filtro/todos_filtro_bloc.dart';
import 'models/todos_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              CarregarTodos(todos: [
                Todo(
                  titulo: 'Estudar Flutter',
                  descricao:
                      'Estudar Flutter para desenvolver aplicativos mobile',
                  estaCompletada: false,
                  estaCancelada: false,
                ),
                Todo(
                  titulo: 'Estudar BLoC',
                  descricao: 'Estudar BLoC para desenvolver aplicativos mobile',
                  estaCompletada: false,
                  estaCancelada: false,
                ),
                Todo(
                  titulo: 'Estudar Firebase',
                  descricao:
                      'Estudar Firebase para desenvolver aplicativos mobile',
                  estaCompletada: false,
                  estaCancelada: false,
                ),
              ]),
            ),
        ),
        BlocProvider(
          create: (context) => TodosFiltroBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          )..add(TodosFiltroAtualiza()),
        ),
      ],
      child: MaterialApp(
        title: 'BLoC - Entendendo o conceito',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF000A1F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF000A1F),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
