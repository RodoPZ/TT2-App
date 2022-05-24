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
  var horarioRepetir;

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
  final String pastillaData;
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
  final String tipo;
  Pin({
    this.tipo = "nfc",
    required this.pin
  });
}
class Nfc{
  final String tipo;
  final String nfcNombre;
  final String uid;
  final bool isAdmin;
  Nfc({
    this.tipo = "nfc",
    required this.nfcNombre,
    required this.uid,
    required this.isAdmin,
  });
}

class FaceRecognition{
  final String tipo;
  final String faceRName;
  final bool isAdmin;
  FaceRecognition({
    this.tipo = "face",
    required this.faceRName,
    required this.isAdmin,
  });
}

