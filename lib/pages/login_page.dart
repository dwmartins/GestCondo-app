import 'package:flutter/material.dart';
import 'package:gestcondo/utils/app_colors.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool remember_me = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool loading = false;

  Future<void> _login() async {
    if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Erro',
              style: TextStyle(
                color: Colors.red
              ),
            ),
            content: const Text(
              'Por favor, preencha todos os campos.',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              )
            ],
          );
        },
      );

      return;
    }

    setState(() => loading = true);

    bool success = await _authService.login(
      _emailController.text,
      _passwordController.text
    );

    setState(() => loading = false);

    if(success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login realizado com sucesso!")),
      );

      _emailController.text = "";
      _passwordController.text = "";
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("E-mail ou senha inválidos")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/cover.png',
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Card(
              margin: EdgeInsets.all(15),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Conecte-se',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor
                        ),
                      ),
                      const Text(
                        'Por favor insira seus dados',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textColor
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 20,
                              color: AppColors.textColor,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: AppColors.primary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 20,
                              color: AppColors.textColor,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: AppColors.primary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                print('Esqueci minha senha clicado');
                              },
                              child: const Text(
                                'Esqueci minha senha',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor: AppColors.primary600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                            ),
                          ),
                          onPressed: loading ? null : _login,
                          child: loading
                              ? CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
