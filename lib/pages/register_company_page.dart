import 'dart:convert';
import 'dart:io';

import 'package:easyfact_mobile/constants/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../ui/ui.dart';

class RegisterCompanyPage extends StatefulWidget {
  const RegisterCompanyPage({super.key});

  @override
  State<RegisterCompanyPage> createState() => _RegisterCompanyPageState();
}

class _RegisterCompanyPageState extends State<RegisterCompanyPage> {
  File? _image;
  File? _firm;
  String _firmName = '';

  final String _baseUrl = '34.75.222.189:8000';

  String? ruc;
  String? razonSocial;
  String? nombreComercial;
  String? direccion;
  String? telefono;
  String? obligadoContabilidad;
  String? tipoContribuyente;
  String? contrasenaFirmaElectronica;
  String? licenciaPer;

  final _formKey = GlobalKey<FormState>();

  Future<int> sendFormData(File logo, File firma) async {
    final url = Uri.http(_baseUrl, '/api/empresa/');
    var request = http.MultipartRequest('POST', url);

    request.fields['licencia_per'] = licenciaPer!;
    request.fields['ruc'] = ruc!;
    request.fields['tipo_contribuyente'] = tipoContribuyente!;
    request.fields['nombre_comercial'] = nombreComercial!;
    request.fields['razon_social'] = razonSocial!;
    request.fields['direccion'] = direccion!;
    request.fields['telefono'] = telefono!;
    request.files.add(await http.MultipartFile.fromPath(
      'logo',
      logo.path,
      // contentType: MediaType('image', 'jpg'),
    ));
    request.fields['lleva_contabilidad'] = 'False';
    request.files.add(await http.MultipartFile.fromPath(
      'firma_electronica',
      firma.path,
      // contentType: MediaType('text', 'plain'),
    ));
    request.fields['contrasena_firma_electronica'] = '1234asdf5';
    request.fields['desarrollo'] = 'True';

    request.headers['Content-Type'] = 'multipart/form-data';

    var response = await request.send();
    print(request.fields);
    if (response.statusCode == 200) {
      // print(response.toString());
      final respStr = await response.stream.bytesToString();
      Map<String, dynamic> data = await jsonDecode(respStr);
      int idEmpresa = data['empresa']['id_empresa'];
      print(idEmpresa);
      return idEmpresa;
    } else {
      print('Error al enviar el formulario');
      return 0;
    }
  }

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  Future getFirm() async {
    final firm = await FilePicker.platform.pickFiles();
    if (firm == null) return;
    // print(firm.names.single);
    _firmName = firm.names.single.toString();
    final firmTemporary = File(firm.files.single.path!);
    setState(() {
      _firm = firmTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Container(
                  height: 75,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      IconButton(
                        alignment: Alignment.centerLeft,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 50,
                        child: Image.asset('assets/images/isotipo_menta.png'),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: 75,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Registra tu empresa',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: FormFieldsStyle().textFormField(
                      hintText: 'test12345',
                      labelText: 'Clave de activación',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    onChanged: (value) {
                      // licenciaPer = value;
                      setState(() {
                        licenciaPer = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese el RUC o RIMPE de su empresa';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: FormFieldsStyle().textFormField(
                      hintText: '1800000000001',
                      labelText: 'RUC o RIMPE',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // ruc = value;
                      setState(() {
                        ruc = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese el RUC o RIMPE de su empresa';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: FormFieldsStyle().textFormField(
                      hintText: 'EasyFact S.A',
                      labelText: 'Razón social',
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // razonSocial = value;
                      setState(() {
                        razonSocial = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese la razón social de su empresa';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: FormFieldsStyle().textFormField(
                      hintText: 'EasyFact',
                      labelText: 'Nombre comercial',
                    ),
                    onChanged: (value) {
                      nombreComercial = value;
                    },
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese el nombre comercial de su empresa';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: FormFieldsStyle().textFormField(
                      hintText: 'Ambato. Av. Los Chasquis y Av. Atahualpa',
                      labelText: 'Dirección',
                    ),
                    onChanged: (value) {
                      // direccion = value;
                      setState(() {
                        direccion = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese la dirección de su empresa';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: FormFieldsStyle().textFormField(
                      hintText: '0999988888',
                      labelText: 'Teléfono de contacto',
                    ),
                    onChanged: (value) {
                      // telefono = value;
                      setState(() {
                        telefono = value;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese la razón social de su empresa';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor seleccione una opción';
                      }
                      return null;
                    },
                    decoration: FormFieldsStyle().textFormField(
                        hintText: 'Seleccione una opción',
                        labelText: 'Obligado a llevar contabilidad'),
                    items: const [
                      DropdownMenuItem(
                        value: 'False',
                        child: Text('No'),
                      ),
                      DropdownMenuItem(
                        value: 'True',
                        child: Text('Sí'),
                      ),
                    ],
                    onChanged: (value) {
                      // obligadoContabilidad = value;
                      setState(() {
                        obligadoContabilidad = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor seleccione una opción';
                      }
                      return null;
                    },
                    decoration: FormFieldsStyle().textFormField(
                        hintText: 'Seleccione una opción',
                        labelText: 'Tipo de contribuyente'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Persona Natural',
                        child: Text('Persona natural'),
                      ),
                      DropdownMenuItem(
                        value: 'Persona Juridica',
                        child: Text('Persona jurídica'),
                      ),
                    ],
                    onChanged: (value) {
                      // tipoContribuyente = value;
                      setState(() {
                        tipoContribuyente = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  // Crear un circulo
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(300),
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage('assets/images/default.png'),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Tu logo',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MaterialButton(
                    onPressed: () {
                      getImage();
                    },
                    color: AppColors.successColor,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Cargar logo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    // 'Tu firma electrónica	',
                    _firmName == '' ? 'Tu firma electrónica' : _firmName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MaterialButton(
                    onPressed: () {
                      getFirm();
                      // print(_firm);
                    },
                    color: AppColors.successColor,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Cargar firma electrónica',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: FormFieldsStyle().textFormField(
                      hintText: '123456789',
                      labelText: 'La contraseña de tu firma electrónica',
                    ),
                    onChanged: (value) {
                      // contrasenaFirmaElectronica = value;
                      setState(() {
                        contrasenaFirmaElectronica = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese la contraseña de su firma electrónica';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MaterialButton(
                    onPressed: () {
                      // sendFormData(_image!, _firm!);
                      if (_formKey.currentState!.validate()) {
                        // sendFormData(_image!, _firm!);
                        sendFormData(_image!, _firm!).then((value) {
                          if (value != 0) {
                            Navigator.pushNamed(
                              context,
                              '/register',
                              arguments: value,
                            );
                          }
                        });
                      }
                    },
                    color: AppColors.primaryColor,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Registrar empresa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
