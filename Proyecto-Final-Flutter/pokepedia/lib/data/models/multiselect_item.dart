// Clase para representar un elemento seleccionable en listas desplegables o filtros
class MultiselectItem {
  final String name;
  final int id;

  MultiselectItem({required this.name, required this.id});

  @override
  String toString() {
    return 'Generation(name: $name, id: $id)';
  }
}