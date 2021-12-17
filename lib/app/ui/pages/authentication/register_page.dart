import 'package:artwork_squad/app/controllers/register_controller.dart';
import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:artwork_squad/app/ui/pages/contenido/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();
  RegisterController registerController = Get.find();

  _register(theEmail, thePassword) async {
    try {
      await registerController.register(theEmail, thePassword);
      Get.offAll(() => HomePage());
    } catch (err) {
      Get.snackbar(
        "Error",
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
                    'https://firebasestorage.googleapis.com/v0/b/artwork-squad.appspot.com/o/galeria-de-arte.png?alt=media&token=35cf5d24-7338-469c-b029-b5256e20a624',
                    height: 150,
                  ),
                ),
                Text(
                  "Registrarse",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Divider(),
                _ingresarEmail(),
                Divider(),
                _ingresarPass(),
                SizedBox(
                  height: 8,
                ),
                _confirmPass(),
                Divider(),
                _registerButton(),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: Text("Iniciar sesión"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _registerButton() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Enviar'),
        ),
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final form = _formKey.currentState;
          form!.save();
          if (_formKey.currentState!.validate()) {
            await _register(textController.text, passController.text);
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
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
                //return null;
              }),
        ],
      ),
    );
  }

  Widget _confirmPass() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          TextFormField(
              controller: this.confirmController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                labelText: 'Confirmar Contraseña',
                suffixIcon: Icon(Icons.lock_open),
                icon: Icon(Icons.lock),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "La contraseña es requerida";
                } else if (value.length < 6) {
                  return "La contraseña debe tener al menos 6 caracteres";
                }
                //return null;
              }),
        ],
      ),
    );
  }
}
