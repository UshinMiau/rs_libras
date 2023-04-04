import 'package:flutter/material.dart';
import 'package:rs_libras/model/DAO/client_dao.dart';
import 'package:rs_libras/model/client.dart';
import 'package:rs_libras/model/preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Client?>(
      future: Preferences.getClient(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final client = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Meu perfil"),
            ),
            body: Container(
              margin: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                          'assets/images/clients/${client.photoPath}'),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Nome:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(client.name),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Sobrenome:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(client.lastName),
                    const SizedBox(height: 8.0),
                    const Text(
                      'ID:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("${client.id}"),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Email:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(client.email),
                    const SizedBox(height: 20.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit_client');
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Editar'),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        Preferences.logout();

                        Navigator.pushReplacementNamed(context, '/');
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Sair da conta'),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final bool deleteConfirmed = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Tem certeza que deseja excluir sua conta?"),
                              content: const Text("Não poderá recuperá-la depois."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text("Cancelar"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text("Confirmar"),
                                ),
                              ],
                            );
                          },
                        );

                        if (deleteConfirmed) {
                          final result = await ClientDAO.delete(client.id!);
                          SnackBar snack;

                          if (result == 1) {
                            Preferences.logout();

                            snack = const SnackBar(
                              content: Text("Conta deletada!"),
                              backgroundColor: Colors.green,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snack);

                            Navigator.pushReplacementNamed(context, '/');
                          } else {
                            snack = const SnackBar(
                              content: Text("Erro ao deletar a conta!"),
                              backgroundColor: Colors.red,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          }
                        }
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Apagar conta'),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Text('Unknown error: ${snapshot.error}');
        }
      },
    );
  }
}
