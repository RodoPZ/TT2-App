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

class Contacto{
  final String contactoNombre;
  final int contactoNumero;

  Contacto({
    required this.contactoNombre,
    required this.contactoNumero,
  });
}

class Dosis{
  final String dosisNombre;
  final List pastillaData;
  final List horarioData;
  final List alarmaData;
  final List seguridadData;

  Dosis({
    required this.dosisNombre,
    required this.pastillaData,
    required this.horarioData,
    required this.alarmaData,
    required this.seguridadData,
  });
}

class Pin{
  final String pin;
  Pin({
    required this.pin
  });
}