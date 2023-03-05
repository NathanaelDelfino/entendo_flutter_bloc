part of 'todos_filtro_bloc.dart';

abstract class TodosFiltroEvent extends Equatable {
  const TodosFiltroEvent();

  @override
  List<Object> get props => [];
}

class FiltroAtualiza extends TodosFiltroEvent {
  const FiltroAtualiza();

  @override
  List<Object> get props => [];
}

class TodosFiltroAtualiza extends TodosFiltroEvent {
  final TodosFiltro filtroDeTodos;

  const TodosFiltroAtualiza({this.filtroDeTodos = TodosFiltro.all});

  @override
  List<Object> get props => [filtroDeTodos];

  @override
  String toString() =>
      'TodosFiltroAtualizado { filtroDeTodos: $filtroDeTodos }';
}
