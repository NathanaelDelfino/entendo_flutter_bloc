part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosCarregando extends TodosState {
  late final List<Todo> todos;
}

class TodosCarregados extends TodosState {
  final List<Todo> todos;

  const TodosCarregados({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosCarregados { todos: $todos }';
}
