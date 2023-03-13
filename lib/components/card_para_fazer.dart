import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos/todos_bloc.dart';
import '../models/todos_model.dart';

class CardParaFazer extends StatefulWidget {
  const CardParaFazer({
    super.key,
    required this.todo,
    required this.atualizarTarefa,
  });
  final Todo todo;
  final Function atualizarTarefa;
  @override
  State<CardParaFazer> createState() => _CardParaFazerState();
}

class _CardParaFazerState extends State<CardParaFazer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.todo.titulo),
        subtitle: Text(widget.todo.descricao),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.add_task,
                color:
                    ObterSeAAtividadeEstaCompleta ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                widget.todo.tarefaCompletada();
                context.read<TodosBloc>().add(AtualizarTodos(widget.todo));
                widget.atualizarTarefa();
                setState(() {
                  ObterSeAAtividadeEstaCompleta;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                context.read<TodosBloc>().add(DeletarTodos(widget.todo));
              },
            ),
          ],
        ),
      ),
    );
  }

  bool get ObterSeAAtividadeEstaCompleta => widget.todo.estaCompletada;
}
