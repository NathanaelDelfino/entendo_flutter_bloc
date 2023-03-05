part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class CarregarTodos extends TodosEvent {
  final List<Todo> todos;

  const CarregarTodos({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

class AdicionarTodos extends TodosEvent {
  final Todo todo;

  const AdicionarTodos(this.todo);

  @override
  List<Object> get props => [todo];
}

class AtualizarTodos extends TodosEvent {
  final Todo todo;

  const AtualizarTodos(this.todo);

  @override
  List<Object> get props => [todo];
}

class DeletarTodos extends TodosEvent {
  final Todo todo;

  const DeletarTodos(this.todo);

  @override
  List<Object> get props => [todo];
}
