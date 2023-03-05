import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todos_filtro_model.dart';
import '../../models/todos_model.dart';
import '../todos/todos_bloc.dart';

part 'todos_filtro_event.dart';
part 'todos_filtro_state.dart';

class TodosFiltroBloc extends Bloc<TodosFiltroEvent, TodosFiltroState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  TodosFiltroBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(TodosFiltroCarregando()) {
    on<TodosFiltroAtualiza>(_aoAtualizarFiltroTodos);
    on<FiltroAtualiza>(_aoAtualizarTodos);

    _todosSubscription = todosBloc.stream.listen((state) {
      add(
        const TodosFiltroAtualiza(),
      );
    });
  }

  void _aoAtualizarTodos(FiltroAtualiza event, Emitter<TodosFiltroState> emit) {
    if (state is TodosCarregados) {
      final state = this.state as TodosFiltroCarregado;
      add(TodosFiltroAtualiza(filtroDeTodos: state.filtroDeTodos));
    }
  }

  void _aoAtualizarFiltroTodos(
      TodosFiltroAtualiza event, Emitter<TodosFiltroState> emit) {
    final state = _todosBloc.state;
    if (state is TodosCarregados) {
      List<Todo> todos = state.todos.where((todo) {
        switch (event.filtroDeTodos) {
          case TodosFiltro.all:
            return true;
          case TodosFiltro.completada:
            return todo.estaCompletada!;
          case TodosFiltro.cancelada:
            return todo.estaCancelada!;
          case TodosFiltro.pendente:
            return !(todo.estaCompletada! || todo.estaCancelada!);
        }
      }).toList();

      emit(
        TodosFiltroCarregado(
          todosFiltrados: todos,
          filtroDeTodos: event.filtroDeTodos,
        ),
      );
    }
  }
}
