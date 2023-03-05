import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todos_model.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosCarregando()) {
    on<CarregarTodos>(_aoCarregarTodos);
    on<AdicionarTodos>(_aoAdicionarTodos);
    on<AtualizarTodos>(_aoAtualizarTodos);
    on<DeletarTodos>(_aoDeletarTodos);
  }

  void _aoCarregarTodos(CarregarTodos event, Emitter<TodosState> emit) {
    emit(
      TodosCarregados(todos: event.todos),
    );
  }

  void _aoAdicionarTodos(AdicionarTodos event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosCarregados) {
      emit(
        TodosCarregados(todos: List.from(state.todos)..add(event.todo)),
      );
    }
  }

  void _aoAtualizarTodos(AtualizarTodos event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosCarregados) {
      var todos = state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();

      emit(
        TodosCarregados(todos: todos),
      );
    }
  }

  void _aoDeletarTodos(DeletarTodos event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosCarregados) {
      var todos =
          state.todos.where((todo) => todo.id != event.todo.id).toList();
      emit(
        TodosCarregados(todos: todos),
      );
    }
  }
}
