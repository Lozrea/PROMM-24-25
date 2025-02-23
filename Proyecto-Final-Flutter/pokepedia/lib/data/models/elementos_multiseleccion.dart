// Clase para representar un elemento seleccionable en listas desplegables o filtros
class ElementoSeleccionMultiple {
  final String name;
  final int id;

  ElementoSeleccionMultiple({required this.name, required this.id});

  @override
  String toString() {
    return 'Generacion(nombre: $name, id: $id)';
  }
}