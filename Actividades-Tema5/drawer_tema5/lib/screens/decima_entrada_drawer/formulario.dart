import 'package:flutter/material.dart';

import '../../widgets/app_drawer.dart';

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>(); // Clave para validar el formulario

  // Expresiones regulares para validación
  final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{8,16}$');
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#~;:.%()\-_+=]).{10,20}$');

  String _nombre = '';
  String _correo = '';
  String _password = '';
  double _edad = 18.0;
  String _genero = '';
  bool _aceptoTerminos = false;

  final List<String> _paises = ['México', 'España', 'Colombia', 'Argentina', 'Estados Unidos', 'Cuba', 'Alemania', 'Canadá', 'Otro'];
  String _paisSeleccionado = 'México'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo: Nombre completo (validado con regex)
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.person),
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _nombre = value),
                validator: (value) {
                  if (value == null || !usernameRegex.hasMatch(value)) {
                    return 'Debe tener entre 8 y 16 caracteres y solo letras, números o "_"';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Correo electrónico (validado con regex)
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.email_outlined),
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => setState(() => _correo = value),
                validator: (value) {
                  if (value == null || !emailRegex.hasMatch(value)) {
                    return 'Ingrese un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Contraseña (validado con regex)
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.key),
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) => setState(() => _password = value),
                validator: (value) {
                  if (value == null || !passwordRegex.hasMatch(value)) {
                    return 'Debe tener 10-20 caracteres, incluir mayúsculas, minúsculas, un número y un símbolo (!@#~;:.%()_-+=)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Slider: Edad
              const Text(
                'Selecciona tu edad:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Slider(
                min: 0,
                max: 100,
                value: _edad,
                divisions: 100,
                label: _edad.toStringAsFixed(0),
                onChanged: (value) => setState(() => _edad = value),
              ),
              Text(
                'Edad: ${_edad.toInt()} años',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Radio button: Género
              const Text(
                'Género:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              RadioListTile<String>(
                title: const Text('Masculino'),
                value: 'Masculino',
                groupValue: _genero,
                onChanged: (value) => setState(() => _genero = value ?? ''),
              ),
              RadioListTile<String>(
                title: const Text('Femenino'),
                value: 'Femenino',
                groupValue: _genero,
                onChanged: (value) => setState(() => _genero = value ?? ''),
              ),
              RadioListTile<String>(
                title: const Text('Otro'),
                value: 'Otro',
                groupValue: _genero,
                onChanged: (value) => setState(() => _genero = value ?? ''),
              ),
              RadioListTile<String>(
                title: const Text('Prefiero no decirlo'),
                value: 'Prefiero no decirlo',
                groupValue: _genero,
                onChanged: (value) => setState(() => _genero = value ?? ''),
              ),
              const SizedBox(height: 16),

              // Dropdown: País de residencia
              const Text(
                'País de residencia:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _paisSeleccionado,
                items: _paises
                    .map((pais) => DropdownMenuItem<String>(
                          value: pais,
                          child: Text(pais),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _paisSeleccionado = value ?? _paisSeleccionado),
              ),
              const SizedBox(height: 16),

              // Checkbox: Aceptar términos y condiciones
              CheckboxListTile(
                title: const Text(
                  'Acepto los términos y condiciones',
                ),
                value: _aceptoTerminos,
                onChanged: (value) => setState(() => _aceptoTerminos = value ?? false),
                subtitle: !_aceptoTerminos
                    ? const Text('Debes aceptar los términos', style: TextStyle(color: Colors.red))
                    : null,
              ),
              const SizedBox(height: 16),

              // Botón para mostrar el resumen
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (_aceptoTerminos) {
                      _mostrarResumen(context);
                    }
                  }
                },
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarResumen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Resumen del Registro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: $_nombre'),
              Text('Correo: $_correo'),
              Text('Edad: ${_edad.toInt()} años'),
              Text('Género: $_genero'),
              Text('País: $_paisSeleccionado'),
              Text('Términos aceptados: ${_aceptoTerminos ? "Sí" : "No"}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}