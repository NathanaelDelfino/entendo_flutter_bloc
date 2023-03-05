import 'package:entendo_flutter_bloc/blocs/todos/todos_bloc.dart';
import 'package:entendo_flutter_bloc/models/todos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerId = TextEditingController();
    var controllerTitulo = TextEditingController();
    var controllerDescricao = TextEditingController();

    return BlocListener<TodosBloc, TodosState>(
      listener: (context, state) {
        if (state is TodosCarregados) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Atividade adicionada com sucesso!'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar atividade'),
        ),
        body: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                //_campoDeTexto('ID', controllerId),
                _campoDeTexto('Titulo', controllerTitulo),
                _campoDeTexto('Descrição', controllerDescricao),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        var todo = Todo(
                          titulo: controllerTitulo.text,
                          descricao: controllerDescricao.text,
                        );
                        context.read<TodosBloc>().add(AdicionarTodos(todo));
                        Navigator.pop(context);
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _campoDeTexto(String tag, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      height: 80,
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          labelText: '$tag:',
        ),
      ),
    );
  }
}
