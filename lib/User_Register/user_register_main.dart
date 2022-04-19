import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:tt2/Components/input_text.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/button_text.dart';
import 'package:tt2/User_Login/login_main.dart';
import 'package:tt2/models.dart';
import 'package:tt2/preferences_service.dart';
enum Options { paciente, administrador }

class RegisterMain extends StatefulWidget {
  const RegisterMain({Key? key}) : super(key: key);

  @override
  State<RegisterMain> createState() => _RegisterMain();
}

class _RegisterMain extends State<RegisterMain>{
  final _preferencesService = PreferencesService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _nombreUsuario;
  late String _apellidoUsuario;
  late String _correo;
  late String _password;
  late bool _esPaciente;
  late String _passTemp;
  Options? _tipoDeCuenta;
  String _radioErrorText = "";

  Widget _buildNombre(){
    return InputText(
      inputText: "Nombre:",
      inputHintText: "Nombre",
      inputmax: 40,
      textSize: 16,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita un nombre";
        }
        return null;
      },
      myOnSave: (String? value) {
        _nombreUsuario = value!;
      },
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[A-zÀ-ú]"))],
    );
  }

  Widget _buildApellido(){
    return InputText(
      inputText: "Apellido:",
      inputHintText: "Apellido",
      inputmax: 40,
      textSize: 16,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita un apellido";
        }
        return null;
      },
      myOnSave: (String? value) {
        _apellidoUsuario = value!;
      },
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[A-zÀ-ú]"))],
    );
  }

  Widget _buildCorreo(){
    return InputText(
      inputText: "Correo:",
      inputHintText: "Correo@ejemplo.com",
      textSize: 16,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita un correo";
        }
        else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)){
          return "No es un formato válido";
        }
        return null;
      },
      myOnSave: (String? value) {
        _correo = value!;
      },

    );
  }

  Widget _buildPassword(){
    return InputText(
      inputText: "Contraseña:",
      inputHintText: "********",
      textSize: 16,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita una contraseña";
        }
        _passTemp = value;
        return null;
      },
      myOnSave: (String? value) {
        _password = value!;
      },
      isPassword: true,
    );
  }

  Widget _buildRepetirPassword(){
    return InputText(
      inputText: "Repetir contraseña:",
      inputHintText: "********",
      textSize: 16,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita una contraseña";
        }
        else if (value!=_passTemp){
          return "Las contraseñas no coinciden!";
        }
        return null;
      },
      isPassword: true,
    );
  }

  Widget _buildTipoDeCuenta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: RadioListTile<Options>(
                  contentPadding: const EdgeInsets.only(
                    right: 0,
                    left: 0,
                  ),
                  title: const Text('Paciente'),
                  value: Options.paciente,
                  groupValue: _tipoDeCuenta,
                  onChanged: (Options? value) {
                    setState(() {
                      _tipoDeCuenta = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<Options>(
                  contentPadding: const EdgeInsets.only(
                    right: 0,
                    left: 0,
                  ),
                  title: const Text('Administrador'),
                  value: Options.administrador,
                  groupValue: _tipoDeCuenta,
                  onChanged: (Options? value) {
                    setState(() {
                      _tipoDeCuenta = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, top: 10),
          child: Text(_radioErrorText,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xffd32f2f),
              )),
        ),
      ],
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView (
          scrollDirection: Axis.vertical,
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                    left: 30,
                    right: 30,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Registro",
                        style: TextStyle(
                          color: Color(0xFF35424a),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildNombre(),
                              _buildApellido(),
                              _buildCorreo(),
                              const SizedBox(height: 20),
                              _buildPassword(),
                              const SizedBox(height: 20),
                              _buildRepetirPassword(),
                              _buildTipoDeCuenta(),
                            ],
                          )),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: ButtonMain(buttonText: "Registrar", callback: (){
                    if(_tipoDeCuenta == null ){
                      setState(() {
                        _radioErrorText = "Seleccionar una tipo de cuenta";
                      });
                    }
                    else{
                      setState(() {
                        _radioErrorText = "";
                        _tipoDeCuenta == Options.paciente ? _esPaciente = true : _esPaciente = false;
                      });
                    }
                    if(!_formKey.currentState!.validate()){
                      return;
                    }
                    _formKey.currentState!.save();
                    _registerUser();
                    const snackBar = SnackBar(
                      content: Text('Usuario registrado con éxito'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  })
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "¿Ya tiene cuenta?",
                      style: TextStyle(
                        color: Color(0xFF989eb1),
                      ),
                    ),
                    ButtonText("Ingresar", Theme.of(context).primaryColor,15,(){
                      _printData();
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => LoginMain()),
                      );
                    }),
                  ],
                  ),
              ],
            ),
        ),
    );
  }

  void _registerUser(){
    final newUser = UserData(
        nombreUsuario: _nombreUsuario,
        apellidoUsuario: _apellidoUsuario,
        correo: _correo,
        password: _password,
        esPaciente: _esPaciente,
    );
    _preferencesService.saveUser(newUser);
  }
  void _printData() async {
    final User = await _preferencesService.getUserData();
  }
}

