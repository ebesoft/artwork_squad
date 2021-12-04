import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:artwork_squad/app/ui/pages/contenido/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final passController = TextEditingController();
  LoginController loginController = Get.find();

  _login(theEmail, thePassword) async {
    try {
      await loginController.login(theEmail, thePassword);
      Get.offAll(() => HomePage());
    } catch (err) {
      Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('ARTwork Squad', style: TextStyle(color: Colors.blueAccent)),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5),
                Flexible(
                  child: Image.network(
                    'https://drive.google.com/uc?export=view&id=1PHWzM2FrD7BZwEe8296CGP07tP1Ie3u8',
                    height: 250,
                  ),
                ),
                Text(
                  "Iniciar sesión",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Divider(),
                _ingresarEmail(),
                Divider(),
                _ingresarPass(),
                Divider(),
                _loginButton(),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.SIGNUP);
                  },
                  child: Text("Registrarse"),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _google();
        },
        child: FaIcon(FontAwesomeIcons.google, color: Colors.white),
      ),
    );
  }

  Widget _loginButton() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Iniciar'),
        ),
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final form = _formKey.currentState;
          form!.save();
          if (_formKey.currentState!.validate()) {
            await _login(textController.text, passController.text);
          }
        },
      );
    });
  }

  Widget _ingresarEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          TextFormField(
              //autofocus: true,
              controller: this.textController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                labelText: 'Ingresar su correo',
                helperText: 'Distingue de mayúsculas y minúsculas',
                suffixIcon: Icon(Icons.accessibility_new),
                icon: Icon(Icons.account_circle_outlined),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "EL email es requerido";
                } else if (!value.contains('@')) {
                  return "Ingresar email valido";
                }
              }),
        ],
      ),
    );
  }

  Widget _ingresarPass() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: this.passController,
            obscureText: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              labelText: 'Ingresar Contraseña',
              suffixIcon: Icon(Icons.lock_open),
              icon: Icon(Icons.lock),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "La contraseña es requerida";
              } else if (value.length < 6) {
                return "La contraseña debe tener al menos 6 caracteres";
              }
              return null;
            },
          )
        ],
      ),
    );
  }

  _google() async {
    try {
      await loginController.ingresarGoogle();
      Get.toNamed(Routes.HOME);
    } catch (err) {
      print(err.toString());
      Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
