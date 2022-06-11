class UserData{
  final String nombreUsuario;
  final String apellidoUsuario;
  final String correo;
  final String password;
  final String pin;

  UserData({
    required this.nombreUsuario,
    required this.apellidoUsuario,
    required this.correo,
    required this.password,
    required this.pin
  });

}

class Pastilla{
  final String pastillaNombre;
  final int pastillaCantidad;
  final String pastillaCaducidad;
  final int contenedor;

  Pastilla({
    required this.contenedor,
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
  final String horarioData;
  final List alarmaData;
  final String seguridadData;
  final Map historial;
  final String uniqueDate;
  Dosis({
    required this.dosisNombre,
    required this.pastillaData,
    required this.horarioData,
    required this.alarmaData,
    required this.seguridadData,
    required this.historial,
    this.uniqueDate = "",
  });
}

class Pin{
  final String nombre;
  final String pin;
  final String tipo;
  final bool admin;
  Pin({
    this.nombre = "Pin",
    required this.admin,
    this.tipo = "PIN",
    required this.pin
  });
}

class Nfc{
  final String tipo;
  final String nfcNombre;
  final String uid;
  final bool isAdmin;
  Nfc({
    this.tipo = "NFC",
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
    this.tipo = "RECONOCIMIENTO FACIAL",
    required this.faceRName,
    required this.isAdmin,
  });
}

