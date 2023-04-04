import 'package:flutter/material.dart';
import 'package:rs_libras/controller/categories.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as String;
    final category =
        categories.firstWhere((element) => element.name == argument);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: category.elements.length,
          itemBuilder: (BuildContext context, int index) {
            final element = category.elements[index];
            Map<String, dynamic> elementArguments = {
              'category': category.name,
              'element': element.id,
            };

            return Card(
              child: ListTile(
                title: Text(element.name),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/element',
                    arguments: elementArguments,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
