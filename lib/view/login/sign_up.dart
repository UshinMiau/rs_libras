import 'package:flutter/material.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:rs_libras/model/DAO/client_dao.dart';
import 'package:rs_libras/model/client.dart';
import 'package:rs_libras/view/login/components/custom_textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar conta"),
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
                  Container(
                    width: 130,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.circular(
                          10), // Definindo o raio da borda
                    ),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var client = Client(
                              photoPath: "assets/images/clients/${nameController.text}.png",
                              name: nameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            
                            int result = await ClientDAO.insert(client.toMap());

                            SnackBar snack;

                            if (result != 0) {
                              snack = const SnackBar(
                                content: Text("Conta cadastrada com sucesso!!!"),
                                backgroundColor: Colors.green,
                              );
                            } else {
                              snack = const SnackBar(
                                content: Text("Não foi possível cadastrar a conta!!!"),
                                backgroundColor: Colors.red,
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          }
                        },
                        child: const Text(
                          "Cadastrar",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_in');
                    },
                    child: const Text(
                      "Já tem uma conta? Entre!",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
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
  }
}
