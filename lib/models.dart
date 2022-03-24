class UserData{
  final String nombreUsuario;
  final String apellidoUsuario;
  final String correo;
  final String password;
  final bool esPaciente;

  UserData({
    required this.nombreUsuario,
    required this.apellidoUsuario,
    required this.correo,
    required this.password,
    required this.esPaciente
  });

}

class Pastilla{
  final String pastillaNombre;
  final int pastillaCantidad;
  final String pastillaCaducidad;

  Pastilla({
    required this.pastillaNombre,
    required this.pastillaCantidad,
    required this.pastillaCaducidad,
  });
}

class Horario{
  final String horarioHora;
  final String horarioRepetir;

  Horario({
    required this.horarioHora,
    required this.horarioRepetir,
  });
}