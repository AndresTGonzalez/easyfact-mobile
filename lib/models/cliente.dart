class Cliente {
  int? idCliente;
  String numeroIdentificacion;
  String nombre;
  String apellido;
  String correo;
  String direccion;
  String telefono;
  String tipoPersona;

  Cliente({
    this.idCliente,
    required this.numeroIdentificacion,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.direccion,
    required this.telefono,
    required this.tipoPersona,
  });

  // Generar una copia del cliente
  Cliente copy() {
    return Cliente(
      idCliente: idCliente,
      numeroIdentificacion: numeroIdentificacion,
      nombre: nombre,
      apellido: apellido,
      correo: correo,
      direccion: direccion,
      telefono: telefono,
      tipoPersona: tipoPersona,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'numero_identificacion': numeroIdentificacion,
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'direccion': direccion,
      'telefono': telefono,
      'tipo_persona': tipoPersona,
    };
  }
}
