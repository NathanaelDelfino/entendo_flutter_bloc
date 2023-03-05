part of 'todos_filtro_bloc.dart';

abstract class TodosFiltroState extends Equatable {
  const TodosFiltroState();

  @override
  List<Object> get props => [];
}

class TodosFiltroCarregando extends TodosFiltroState {}

class TodosFiltroCarregado extends TodosFiltroState {
  final List<Todo> todosFiltrados;
  final TodosFiltro filtroDeTodos;

  const TodosFiltroCarregado({
    required this.todosFiltrados,
    this.filtroDeTodos = TodosFiltro.all,
  });

  @override
  List<Object> get props => [
        todosFiltrados,
        filtroDeTodos,
      ];
}
