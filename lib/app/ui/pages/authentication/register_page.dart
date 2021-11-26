import 'package:artwork_squad/app/controllers/register_controller.dart';
import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  final _textController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('ARTwork Squad', style: TextStyle(color: Colors.blueAccent)),
        centerTitle: true,
        backgroundColor: Colors.black87,
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
                Flexible(
                  child: Image.asset(
                    '../assets/logo/arte.png',
                    height: 250,
                  ),
                ),
                Text(
                  "Registrarse",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingresar su correo',
                  ),
                ),
                Divider(),
                TextField(
                  controller: _textController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingresar contraseña',
                  ),
                ),
                Divider(),
                TextField(
                  controller: _confirmController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'confirmar contraseña',
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
                        Get.toNamed(Routes.HOME, arguments: name);
                      }
                    },
                    child: Text("Enviar")),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text("Iniciar sesión"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
