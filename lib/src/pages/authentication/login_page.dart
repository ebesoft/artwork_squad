import 'package:artwork_squad/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Iniciar sesión",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingresar su correo',
                  ),
                ),
                Divider(),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingresar contraseña',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_textController.text.isEmpty) {
                        Get.snackbar('Error', 'Value can not be empty',
                            icon: Icon(Icons.alarm),
                            backgroundColor: Colors.red);
                      } else {
                        final name = _textController.text;
                        Get.offNamed(HOME_ROUTE, arguments: name);
                      }
                    },
                    child: Text("Iniciar")),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed(SIGNUP_ROUTE);
                    },
                    child: Text("Registrarse"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
