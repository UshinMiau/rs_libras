import 'package:flutter/material.dart';
import 'package:rs_libras/model/DAO/client_dao.dart';
import 'package:rs_libras/model/preferences.dart';
import 'package:rs_libras/view/login/components/custom_textformfield.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar na conta"),
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
                        return "A senha não válida";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 100,
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
                            final result =
                                await ClientDAO.getClientByEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );

                            if (result == null) {
                              SnackBar snack = const SnackBar(
                                content: Text(
                                    "Login inválido! E-mail ou senha incorretos!"),
                                backgroundColor: Colors.red,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            }
                            else {
                              print("Login correto!");

                              Preferences.login(result);

                              Navigator.pushReplacementNamed(context, '/');
                            }
                          }
                        },
                        child: const Text(
                          "Entrar",
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
                      Navigator.pushNamed(context, '/sign_up');
                    },
                    child: const Text(
                      "Não tem uma conta ainda? Cadastre-se!",
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
