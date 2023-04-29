import 'package:flutter/material.dart';

// всплывающее окно с информацией о правилах ввода данных
class InfoButton extends StatelessWidget {
  const InfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Важная информация'),
      content: const Text(
          'Для решения головоломки нужно, оставив одну клетку пустой, ввести в остальные'
          ' целые числа от 1 до 8 '
          'и нажать кнопку "Решить"'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(
            context,
          ),
          child: const Text('Я молодец, я все понял'),
        ),
      ],
    );
  }
}
