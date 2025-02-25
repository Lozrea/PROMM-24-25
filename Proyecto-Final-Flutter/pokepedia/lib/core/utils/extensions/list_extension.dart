// Permite agregar o eliminar un elemento de la lista de manera automática
extension ListWithToggleExtension on List {
  // Agrega o elimina un elemento de la lista, dependiendo de si ya está presente o no
  void toggleElement(Object? element) {
    if (contains(element)) {
      remove(element);
    } else {
      add(element);
    }
  }
}