import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  String? id;
  final String titulo;
  final String descricao;
  bool? estaCompletada;
  bool? estaCancelada;

  Todo({
    required this.titulo,
    required this.descricao,
    this.estaCompletada,
    this.estaCancelada,
    String? id,
  }) {
    estaCompletada = estaCompletada;
    estaCancelada = estaCancelada ?? false;
    this.id = id ?? const Uuid().v4();
  }

  Todo CopyWith({
    String? id,
    String? titulo,
    String? descricao,
    bool estaCompletada = false,
    bool? estaCancelada,
  }) {
    return Todo(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      estaCompletada: estaCompletada,
      estaCancelada: estaCancelada ?? this.estaCancelada,
    );
  }

  void tarefaCompletada() {
    estaCompletada = !estaCompletada!;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        titulo,
        descricao,
        estaCompletada,
        estaCancelada,
      ];

  static List<Todo> todos = [
    Todo(
      titulo: 'Estudar Flutter',
      descricao: 'Estudar Flutter para desenvolver aplicativos mobile',
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
      descricao: 'Estudar Firebase para desenvolver aplicativos mobile',
      estaCompletada: false,
      estaCancelada: false,
    ),
  ];
}
