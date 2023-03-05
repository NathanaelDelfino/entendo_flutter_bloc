import 'package:flutter/material.dart';

class SobreBLoC extends StatelessWidget {
  const SobreBLoC({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'BLoC - Entendendo o conceito',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'BLoC é um padrão de arquitetura que visa separar a lógica de negócio da interface do usuário. '
          'O BLoC é responsável por gerenciar o estado da aplicação, '
          'enquanto a interface do usuário é responsável por exibir o estado atual da aplicação.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
