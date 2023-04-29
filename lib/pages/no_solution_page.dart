import 'package:flutter/material.dart';

// страница отображается, если решения головоломки не существует
class NoSolutionPage extends StatelessWidget {
  const NoSolutionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Печальное сообщение')),
        body: Container(
          padding: const EdgeInsets.all(35),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            
            children: [
              Image.asset("assets/images/sad_cat.jpg"),
              Padding(padding: const EdgeInsets.only(top:20),child: Text('Головоломка не имеет решения(',
                style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center), )
            ],
          ),
        ));
  }
}
