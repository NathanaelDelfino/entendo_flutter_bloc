import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos/todos_bloc.dart';
import '../models/todos_model.dart';

class CardParaFazer extends StatefulWidget {
  const CardParaFazer({super.key, required this.todo});
  final Todo todo;
  @override
  State<CardParaFazer> createState() => _CardParaFazerState();
}

class _CardParaFazerState extends State<CardParaFazer> {
  @override
  Widget build(BuildContext context) {
    var completada = widget.todo.estaCompletada;
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
                color: completada ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                completada = !completada;
                widget.todo.tarefaCompletada();
                context.read<TodosBloc>().add(AtualizarTodos(widget.todo));
                setState(() {
                  completada = widget.todo.estaCompletada!;
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
}
