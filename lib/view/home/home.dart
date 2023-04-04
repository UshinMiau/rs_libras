import 'package:flutter/material.dart';
import 'package:rs_libras/controller/categories.dart';
import 'package:rs_libras/model/client.dart';
import 'package:rs_libras/model/preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Client?>(
      future: Preferences.getClient(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("RS Libras"),
              leading: Container(
                margin: const EdgeInsets.all(8),
                child: Image.asset("assets/images/logo.png"),
              ),
              actions: [
                Container(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.red[700],
                        padding: const EdgeInsets.all(10),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Meu Perfil",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              margin: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = categories[index];
                  return Card(
                    child: ListTile(
                      title: Text(category.name),
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: category.name);
                      },
                    ),
                  );
                },
              ),
            ),
          );
        }
        else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("RS Libras"),
              leading: Container(
                margin: const EdgeInsets.all(8),
                child: Image.asset("assets/images/logo.png"),
              ),
              actions: [
                Container(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign_in');
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.red[700],
                        padding: const EdgeInsets.all(10),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Entrar",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              margin: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = categories[index];
                  return Card(
                    child: ListTile(
                      title: Text(category.name),
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: category.name);
                      },
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
