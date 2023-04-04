import 'package:flutter/material.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:rs_libras/model/DAO/client_dao.dart';
import 'package:rs_libras/model/client.dart';
import 'package:rs_libras/model/preferences.dart';
import 'package:rs_libras/view/login/components/custom_textformfield.dart';

class EditClient extends StatefulWidget {
  const EditClient({super.key});

  @override
  State<EditClient> createState() => _EditClientState();
}

class _EditClientState extends State<EditClient> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

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
          final Client client = snapshot.data!;
          
          nameController.text = client.name;
          lastNameController.text = client.lastName;
          emailController.text = client.email;
          passwordController.text = client.password;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Editar perfil"),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt),
                          iconSize: 100,
                          color: Colors.red[700],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          label: "Nome",
                          controller: nameController,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "O campo não pode ficar vazio";
                            } else if (value != null && value.length < 2) {
                              return "O campo deve possuir ao menos 2 caracteres";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          label: "Sobrenome",
                          controller: lastNameController,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "O campo não pode ficar vazio";
                            } else if (value != null && value.length < 2) {
                              return "O campo deve possuir ao menos 2 caracteres";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          label: "Email",
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "O campo não pode ficar vazio";
                            } else if (value != null && validatorEmail(value)) {
                              return "O email não é válido";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          label: "Senha",
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "O campo não pode ficar vazio";
                            } else if (value != null && value.length < 8) {
                              return "O campo deve possuir ao menos 8 caracteres";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var updateClient = Client(
                                id: client.id,
                                photoPath: "assets/images/clients/${nameController.text}.png",
                                name: nameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              
                              int result = await ClientDAO.update(updateClient.toMap());

                              SnackBar snack;

                              if (result != 0) {
                                snack = const SnackBar(
                                  content: Text("Conta editada com sucesso!!!"),
                                  backgroundColor: Colors.green,
                                );

                                Preferences.login(client);

                                Navigator.pushReplacementNamed(context, '/profile');
                              } else {
                                snack = const SnackBar(
                                  content: Text("Não foi possível editar os dados da conta!!!"),
                                  backgroundColor: Colors.red,
                                );
                              }
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            }
                          },
                          child: const Text(
                            "Finalizar",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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