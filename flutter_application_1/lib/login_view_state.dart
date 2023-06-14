import 'package:flutter/material.dart';
import 'MyHomePage.dart';
import 'login.view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

bool isKeyboardVisible = false;

KeyboardVisibilityController keyboardVisibilityController =
    KeyboardVisibilityController();

@override
void dispose() {}

class LoginViewState extends State<LoginView> {
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    void _mostrarBottomSheetCastro(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image(
                      image: AssetImage('assets/cadastro.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Center(
                    child: Text(
                  'Cadastre-se',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
                )),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                      hintText: 'Nome',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xff2E4599),
                        ),
                      )),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xff2E4599)),
                      )),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: matriculaController,
                  decoration: InputDecoration(
                      hintText: 'Matrícula',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xff2E4599)),
                      )),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xff2E4599)),
                      )),
                ),
                const SizedBox(height: 16.0),
                Center(
                    child: SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2E4599),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            // Lógica para realizar o cadastro
                            String nome = nomeController.text.trim();
                            String email = emailController.text.trim();
                            String matricula = matriculaController.text.trim();
                            String senha = senhaController.text.trim();

                            if (nome.isEmpty ||
                                email.isEmpty ||
                                matricula.isEmpty ||
                                senha.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Erro'),
                                      content: const Text(
                                          'Por Favor, preencha todos os campos'),
                                      actions: <Widget>[
                                        TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    );
                                  });
                            } else {
                              final Url =
                                  'https://agenda-production-8c38.up.railway.app/cadastro';
                              final body = {
                                'nome_usuario': nome,
                                'email_usuario': email,
                                'id_matricula': matricula,
                                'senha_usuario': senha,
                              };
                              final response = await http.post(
                                  Uri.parse(
                                      'https://agenda-production-8c38.up.railway.app/cadastro'),
                                  body: body);

                              if (response.statusCode == 200) {
                                // Cadastro realizado com sucesso,
                                if (response.body == 'success') {}
                              }
                            }
                          },
                          child: const Text('Cadastre-se'),
                        ))),
              ],
            ),
          ));
        },
      );
    }

    void _mostrarBottomSheetRecuperarSenha(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image(
                      image: AssetImage('assets/recuperarsenha.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'ESQUECEU A SUA SENHA?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      color: Color(0xff2E4599),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Por favor, informe o E-mail associado a sua conta que enviaremos um link para o mesmo com as instruções para restauração da sua senha.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 16,
                    color: Color(0xff2E4599),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xff2E4599)),
                    ),
                  ),
                ),
                // Lógica para recuperar o e-mail digitado
                const SizedBox(height: 16.0),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2E4599),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Lógica para enviar a solicitação de recuperação de senha
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Recuperar',
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffededed),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFededed),
            ),
          ),
          Container(
            height: 555,
            decoration: const BoxDecoration(
              color: Color(0xff2E4599),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          Positioned(
            width: 300,
            height: 300,
            top: 90,
            left: 40,
            child: Image.asset("assets/logoNassau.png"),
          ),
          const Positioned(
            top: 320,
            left: 80,
            child: Column(
              children: [
                Text(
                  'Acesse sua conta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFededed),
                    fontSize: 25,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 375,
            left: 36,
            child: SizedBox(
              width: 320,
              height: 45,
              child: TextFormField(
                controller: matriculaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Matrícula',
                  filled: true,
                  fillColor: const Color(0xFFededed),
                  hintStyle: const TextStyle(
                    color: Color(0xff2E4599),
                    fontFamily: 'Comfortaa',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe sua matrícula';
                  }
                  return null;
                },
              ),
            ),
          ),
          Positioned(
            top: 440,
            left: 36,
            child: SizedBox(
              width: 320,
              height: 45,
              child: TextFormField(
                controller: senhaController,
                obscureText: isPasswordObscured,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Senha',
                  filled: true,
                  fillColor: const Color(0xFFededed),
                  hintStyle: const TextStyle(
                    color: Color(0xff2E4599),
                    fontFamily: 'Comfortaa',
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordObscured = !isPasswordObscured;
                      });
                    },
                    icon: Icon(
                      isPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xff2E4599),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 505,
            left: 165,
            child: InkWell(
              onTap: () {
                _mostrarBottomSheetRecuperarSenha(context);
              },
              child: const Text(
                'Recupere a sua senha',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Color(0xFFededed),
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 36,
            right: 36,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  String matricula = matriculaController.text.trim();
                  String senha = senhaController.text.trim();

                  if (matricula.isEmpty) {
                    // Verificar se a matrícula está vazia
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erro'),
                          content:
                              const Text('Por favor, informe a matrícula.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (senha.isEmpty) {
                    // Verificar se a senha está vazia
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erro'),
                          content: const Text('Por favor, informe a senha.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Validação bem-sucedida, redirecione para a tela MyHomePage
                    final url =
                        'https://agenda-production-8c38.up.railway.app/usuario';
                    final body = {'matricula': matricula, 'senha': senha};

                    http.post(Uri.parse(url), body: body).then((response) {
                      if (response.statusCode == 200) {
                        // A resposta foi bem-sucedida, verificar o conteúdo retornado
                        if (response.body == 'valid') {
                          // Matrícula e senha válidas, redirecionar para a tela MyHomePage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        } else {
                          // Matrícula ou senha inválidas, exibir mensagem de erro
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Erro'),
                                content:
                                    const Text('Matrícula ou senha inválidas.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        // A solicitação ao backend falhou, exibir mensagem de erro genérica
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Erro'),
                              content:
                                  const Text('Ocorreu um erro ao fazer login.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  }
                },
                icon: const Icon(Icons.login),
                label: const Text('Entrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2E4599),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 695,
            left: 85,
            child: Text(
              'Ainda não tem uma conta?',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                color: Color(0xff2E4599),
                fontSize: 16,
              ),
            ),
          ),
          Positioned(
            top: 725,
            left: 150,
            child: InkWell(
              onTap: () {
                _mostrarBottomSheetCastro(context);
              },
              child: const Text(
                'Cadastre-se',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Color(0xff2E4599),
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
